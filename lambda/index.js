const { PrismaClient } = require('@prisma/client');
const AWS = require('aws-sdk');

const secretsManager = new AWS.SecretsManager();
let prisma;

exports.handler = async (event, context) => {
  context.callbackWaitsForEmptyEventLoop = false;

  if (!prisma) {
    const secretValue = await secretsManager.getSecretValue({ SecretId: 'mySecretId' }).promise();
    const secret = JSON.parse(secretValue.SecretString);

    prisma = new PrismaClient({
      datasources: {
        db: {
          url: secret.DATABASE_URL
        }
      }
    });
  }

  try {
    const token = event.queryStringParameters.token;

    if (token) {
      const user = await prisma.user.findFirst({
        where: { emailVerifiedToken: token },
      });

      if (user) {
        await prisma.user.update({
          where: { id: user.id },
          data: { emailVerifiedToken: null, emailVerified: true },
        });
        return {
          statusCode: 302,
          headers: { Location: `${process.env.NEXTAUTH_URL}/email-verified` },
        };
      } else {
        return {
          statusCode: 200,
          body: JSON.stringify({ message: 'token not found' }),
        };
      }
    } else {
      return {
        statusCode: 200,
        body: JSON.stringify({ message: 'token not provided' }),
      };
    }
  } catch (error) {
    console.error("An error occurred on email verification:", error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: error.message }),
    };
  }
};
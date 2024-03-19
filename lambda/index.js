exports.handler = async (event, context) => {
  try {
      // Versuche, das Token aus dem Event-Objekt zu extrahieren
      const token = event.queryStringParameters && event.queryStringParameters.token;
      
      if (!token) {
          throw new Error('Token fehlt');
      }
      
      console.log('Token:', token);
      return {
          statusCode: 200,
          body: JSON.stringify({ message: 'Token erfolgreich empfangen' })
      };
  } catch (error) {
      console.error('Fehler:', error);
      return {
          statusCode: 400,
          body: JSON.stringify({ message: 'Fehler beim Verarbeiten des Tokens' })
      };
  }
};

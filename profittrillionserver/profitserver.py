from google.appengine.ext import webapp

import json
import logging
import copy

ids = 0
games = dict()

profitDict = {
    "Ceres": 522.0,
    "Isis": 521.0,
    "Hestia": 453.0,
    "Doris": 371.0,
    "Angelina": 797.0,
    "Niobe": 490.0,
    "Beatrix": 456.0,
    "Aurora": 390.0,
    "Aegle": 398.0,
    "Lydia": 539.0,
    "Kassandra": 836.0,
    "Meliboea": 423.0,
    "Juewa": 435.0,
    "Polana": 847.0,
    "Adria": 675.0,
    "Baucis": 720.0,
    "Ino": 388.0,
    "Oceana": 531.0,
    "Russia": 759.0,
    "Kriemhild": 546.0,
    "Bettina": 427.0,
    "Aletheia": 501.0,
    "Amalia": 747.0,
    "Bavaria": 803.0,
    "Heidelberga": 972.0,
    "Lacadiera": 379.0,
    "Dorothea": 613.0,
    "Pariana": 369.0,
    "May": 532.0,
    "Padua": 912.0,
    "Aeria": 557.0,
    "Dodona": 519.0,
    "Janina": 554.0,
    "Delia": 795.0,
    "Vienna": 997.0,
    "Admete": 649.0,
    "Natalie": 609.0,
    "Venusia": 430.0
}

def _game_from_blob(body):
    global games
    jsonDict = json.loads(body)
    return games[jsonDict["gameId"]], jsonDict

def _set_response(response, responseDict):
    response.headers['Content-Type'] = 'application/json'
    response.out.write(json.dumps(responseDict)) # Game ID


class Game():
    def __init__(self, playerOne, playerTwo=None):
        global ids
        self.gameId = ids+1
        ids = self.gameId
        self.playerOne = playerOne
        self.playerTwo = playerTwo
        self.asteroids = copy.deepcopy(profitDict)
    
    def has_started(self):
        return self.playerTwo is not None and self.playerOne is not None

class Player():
    def __init__(self, name, location, color, profit=0):
        self.name = name
        self.location = location
        self.color = color
        self.profit = profit

class Start(webapp.RequestHandler):
    def post(self):
        global games
        responseDict = {}
        try:
            player = json.loads(self.request.body)
            logging.error("Starting new game for player " + player["name"])
            game = Game(player)
            games[game.gameId] = game
            responseDict["gameId"] = game.gameId
        except Exception as e:
            logging.error("Exception reading data for new game." + str(e))
        _set_response(self.response, responseDict)
        
    def get(self):
        global games
        responseDict = {}
        try:
            gameId = json.loads(self.request.get("gameId"))
            logging.error("request for game data with id '%s'" % gameId)
            game = games[gameId]
            if (game):
                responseDict["started"] = game.has_started()
                logging.error("game has started %s" % game.has_started())
                if game.has_started():
                    responseDict["opponent"] = game.playerTwo
            else:
                responseDict["gameLost"] = True;
                logging.error("No game found for id: %s" % gameId)
        except Exception as e:
            logging.error("Exception reading data for game check. " + str(e))
            responseDict["gameLost"] = True
       
        _set_response(self.response, responseDict)

class Move(webapp.RequestHandler):        
    def post(self):
        global games
        responseDict = {}
        try:
            move = json.loads(self.request.body)
            game = games[move["gameId"]]
            name = move["name"]
            target = move["target"]
            mined = move["mined"]
            opponent = game.playerTwo if game.playerOne.name == name else game.playerOne
            player = game.playerOne if game.playerOne.name == name else game.playerTwo
            sourceMetals = game.asteroids[player.location]
            moveAllowed = opponent.location != target
            mineAllowed = sourceMetals - mined > -3
            responseDict["moveAllowed"] = moveAllowed
            responseDict["mineAllowed"] = mineAllowed
            if mineAllowed:
                game.asteroids[player.location] = sourceMetals - mined
            if moveAllowed:
                player.location = target
                player.profit = move["profit"]
        except:
            logging.error("Exception reading data for move.")
            pass
        _set_response(self.response, responseDict)
        
class Join(webapp.RequestHandler):
    def post(self):
        responseDict = {}
        try:
            jsonDict = json.loads(self.request.body)
            game = games[jsonDict["gameId"]]
            game.playerTwo = jsonDict["player"]
            responseDict["started"] = game.has_started()
            responseDict["gameId"] = game.gameId
            responseDict["opponent"] = game.playerOne
        except Exception as e:
            logging.error("Exception reading data joining game. " + str(e))
            responseDict["started"] = False
        _set_response(self.response, responseDict)        
         
    
    def get(self):
        global games
        logging.error("Request for list of games")
        openGames = [[game.gameId, game.playerOne["name"], game.playerOne["color"]] for game in games.itervalues() if not game.has_started()]
        logging.error("Returning list of %s open games" % len(openGames))
        _set_response(self.response, openGames)        


app = webapp.WSGIApplication([
        ('/move', Move),
        ('/start', Start),
        ('/join', Join)
        ], debug=True)
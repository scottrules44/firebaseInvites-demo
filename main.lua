local googleSignIn = require "plugin.googleSignIn"
local json = require("json")
googleSignIn.init()

local firebaseInvites = require "plugin.firebaseInvites"
firebaseInvites.init()

local widget = require("widget")
local androidClientID = "652763858765-hq7huph5a5to4m39gqsoo7cn0ih3bd3d.apps.googleusercontent.com"
local clientID = "652763858765-ati8ar1t20ofebu4a39nhk7ea9oqmuu1.apps.googleusercontent.com" -- iOS deafult
if (system.getInfo("platform") == "android") then
    clientID = androidClientID
end

local bg  = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 1,.5,0 )

local title = display.newText( "Firebase Invites", display.contentCenterX, 40, native.systemFontBold, 30 )
title:setFillColor(1,0,0)

local showInvites
showInvites = widget.newButton( {
  x = display.contentCenterX,
  y = display.contentCenterY-100,
  id = "showInvites",
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
  label = "Show Invites",
  onEvent = function ( e )
    if (e.phase == "ended") then
      firebaseInvites.show("Come to my app", "cool app title", "CoronaTestApp", nil, nil, function ( ev )
        if (ev.isError == true) then
          native.showAlert("Invites error", json.encode(ev), {"Ok"})
        end
      end)
    end
  end
} )

local signIn = widget.newButton( {
	label = "Sign In",
	fontSize = 20,
	labelColor = { default={ 1, 1, 1 } },
	x = display.contentCenterX,
	y = display.contentCenterY,
	onRelease = function ( e )
      googleSignIn.signIn(clientID, nil,nil,function ( ev )
          if (ev.isError == true) then
              native.showAlert("Error Sign In", ev.error, {"Ok"})
          else
              native.showAlert("Signed In", json.encode(ev), {"Ok"})
          end
		end)
	end,
} )
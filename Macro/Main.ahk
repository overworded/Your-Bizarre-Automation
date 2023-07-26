InventorySearch(ItemName)
{
  send {``}
  sleep 50
  send {click 1170 670} ; click inv search button
  send, %ItemName%
  return
}

ClickFoundImage(Image) ; Image variable is the image name!
{
  ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, Images\%Image%.png

  if ErrorLevel = 2
  {
    MsgBox, Image search failed with the ErrorLevel of %ErrorLevel%. This is an issue with the ImageSearch function.
    return false
  }
  else if ErrorLevel = 1
  {
    return false
  }
  else
  {
    send {click %FoundX% %FoundY%}
    return true
  }
}

GetMaxWorthy()
{
  send {click 1850 970} ; open menu
  sleep 650
  send {click 950 380} ; open character
  sleep 500
  send {click 1200 390} ; open skill tree
  sleep 1250 ; wait for skill tree to open
  send {click 1100 100} ; click first skill tree 
  sleep 500
  send {click 1100 100} ; skill tree
  sleep 250
  send {click 675 250} ; skill tree
  sleep 250
  send {click 970 535} ; skill tree
  sleep 50
  send {click 960 1000} ; close skill tree
  sleep 500
  send {click 1860 985} ; close menu
}

EquippedShinyCheck()
{
  ImageSearch, FoundX, FoundY, 580, 360, 1040, 444, *100 Images\Shiny.png
  if ErrorLevel = 2
  {
    MsgBox, Image search failed with the ErrorLevel of %ErrorLevel%. This is an issue with the ImageSearch function. (Macro paused.)
    Pause, On
    return true
  }
  else if ErrorLevel = 1
  {
    return false
  }
  else
  {
    MsgBox, Shiny detected. (Macro paused.)
    return true
  }
}

DialogueV1()
{
  sleep 100
  send {click 730 670}
  sleep 4000
  send {click 730 670}
}

DialogueV2()
{
  sleep 250
  send {click 1250 680}
  sleep 250
  send {click 1250 680}
  sleep 250
  send {click 1250 680}
  sleep 250
  send {click 1250 680}
}

ArrowCycle()
{
  GetMaxWorthy()
  sleep 500
  InventorySearch("Mysterious")
  sleep 500
  if ClickFoundImage("Mysterious")
  {
    send {``}
    DialogueV2()
    sleep 500
    send {click 1850 970}
    sleep 700
    send {click 975 460}
  }
  else
  {
    MsgBox, Mysterious Arrow not found. (Macro paused.)
    Pause, On
  }
}

RibCycle()
{
  GetMaxWorthy()
  sleep 500
  InventorySearch("Rib")
  sleep 500
  if ClickFoundImage("Rib")
  {
    send {``}
    DialogueV1()
    sleep 500
    send {click 1850 970}
    sleep 700
    send {click 975 460}
  }
  else
  {
    MsgBox, Rib not found. (Macro paused.)
    Pause, On
  }
}

UseRoka()
{
  InventorySearch("Roka")
  sleep 500
  if ClickFoundImage("Roka")
  {
    send {``}
    DialogueV2()
  }
  else
  {
    MsgBox, Roka not found. (Macro paused.)
    Pause, On
  }
}

Delete::
UseRoka()
return

-::
GetMaxWorthy()
return

Insert::
ArrowCycle()
return

Home::
RibCycle()
return

=::
EquippedShinyCheck()
return

.::
Pause, Off
return

PgUp::
Loop
{
  ArrowCycle()
  sleep 11000
  ; if there is an equipped shiny then break the loop 
  if EquippedShinyCheck()
  {
    Pause, On
    break
    return
  }
  sleep 50
  send {click 1860 985} ; close menu
  sleep 250
  UseRoka()
  sleep 6000
}
return

PgDn::
Loop
{
  RibCycle()
  sleep 11000
  if EquippedShinyCheck()
  {
    Pause, On
    break
    return
  }
  sleep 50
  send {click 1860 985} ; close menu
  sleep 250
  UseRoka()
  sleep 6000
}

Tab::
reload
return
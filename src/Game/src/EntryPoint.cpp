#include <SDL3/SDL.h>
#include "SDL3_image/SDL_image.h"

#include <iostream>
#include <vector>

#include "Game/Game.h"

int main()
{
    Game::PlatformerGame game;
    game.Init();
    game.Close();

    return 0;
}

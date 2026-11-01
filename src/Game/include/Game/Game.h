#pragma once
#include <vector>
#include <SDL3/SDL_render.h>
#include <SDL3_image/SDL_image.h>

#include "Core/HString.h"
#include "Engine/Test.h"


namespace Game
{
    class PlatformerGame
    {
    public:
        bool Init();
        void Start();
        void Close();
    };
}

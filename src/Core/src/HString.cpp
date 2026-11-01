#include "Core/HString.h"

namespace Core
{
    char HString::hashTable[hashTableSize][hashTableMaxStringLength] = { {'\0'} };
    HString HString::None = HString();
    std::mutex HString::hashTableMutex;
}
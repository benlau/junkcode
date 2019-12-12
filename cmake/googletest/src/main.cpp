#include <string>
#include <gtest/gtest.h>

class Fixture : public ::testing::Test
{
};

TEST_F(Fixture, Dummy) {
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

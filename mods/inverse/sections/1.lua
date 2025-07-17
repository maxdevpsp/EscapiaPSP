return {
    sounds = {
        click = "assets/sfx/click_x.wav"
    },
    rooms = {
        -- ID 1
        {
            -- The room image to be displayed
            img = "assets/png/rooms/1.png",
            load = 1,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                5,
                nil,
                nil,
                2,
                nil
            },
            interact = {
                {
                    -- Interaction rectangle for collision
                    x = 26,
                    y = 58,
                    w = 198,
                    h = 133,
                    -- Action details
                    action = {
                        "dialogue_move", -- Type of the action
                        6, -- If move or dialogue_move, what room does it move to
                        1 -- if dialogue or dialogue_move, what dialogue ID to show
                    },
                },
                {
                    x = 265,
                    y = 141,
                    w = 126,
                    h = 108,
                    action = {
                        "move",
                        8
                    }
                },
                {
                    x = 324,
                    y = 104,
                    w = 50,
                    h = 25,
                    action = {
                        "dialogue_move",
                        10,
                        13
                    }
                },
                {
                    x = 291,
                    y = 87,
                    w = 38,
                    h = 16,
                    action = {
                        "dialogue_move",
                        11,
                        12
                    }
                }
            }
        },
        -- ID 2
        {
            -- The room image to be displayed
            img = "assets/png/rooms/2.png",
            load = 1,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                1,
                nil,
                nil,
                3,
                nil
            },
            interact = {
                {
                    x = 214,
                    y = 78,
                    w = 90,
                    h = 139,
                    action = {
                        "dialogue_move",
                        14,
                        15
                    }
                }
            }
        },
        -- ID 3
        {
            -- The room image to be displayed
            img = "assets/png/rooms/3.png",
            load = 1,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                2,
                nil,
                nil,
                4,
                nil
            },
            interact = {
                {
                    x = 291,
                    y = 87,
                    w = 38,
                    h = 16,
                    action = {
                        "dialogue_move",
                        6,
                        12
                    }
                }
            }
        },
        -- ID 4
        {
            -- The room image to be displayed
            img = "assets/png/rooms/4.png",
            load = 1,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                3,
                nil,
                nil,
                5,
                nil
            },
            interact = {
                {
                    x = 291,
                    y = 87,
                    w = 38,
                    h = 16,
                    action = {
                        "dialogue_move",
                        6,
                        12
                    }
                }
            }
        },
        -- ID 5
        {
            -- The room image to be displayed
            img = "assets/png/rooms/5.png",
            load = 1,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                4,
                nil,
                nil,
                1,
                nil
            },
            interact = {
                {
                    x = 291,
                    y = 87,
                    w = 38,
                    h = 16,
                    action = {
                        "dialogue_move",
                        6,
                        12
                    }
                }
            }
        },
        -- ID 6 - Poster close-up
        {
            -- The room image to be displayed
            img = "assets/png/rooms/6.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil
            },
            interact = {
                {
                    x = 103,
                    y = 25,
                    w = 285,
                    h = 226,
                    action = {
                        "dialogue",
                        2
                    }
                },
                {
                    x = 387,
                    y = 29,
                    w = 40,
                    h = 136,
                    action = {
                        "move",
                        7
                    }
                },
            }
        },
        -- ID 7 - Right to the poster
        {
            -- The room image to be displayed
            img = "assets/png/rooms/7.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil
            },
            interact = {
                {
                    x = 275,
                    y = 0,
                    w = 23,
                    h = 272,
                    action = {
                        "dialogue",
                        3
                    }
                },
                {
                    x = 0,
                    y = 87,
                    w = 93,
                    h = 53,
                    action = {
                        "dialogue",
                        4
                    }
                }, 
            }
        },
        -- ID 8 - Hockey table
        {
            -- The room image to be displayed
            img = "assets/png/rooms/8.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil,
            },
            interact = {
                {
                    x = 139,
                    y = 49,
                    w = 145,
                    h = 40,
                    action = {
                        "dialogue",
                        6
                    }
                },
                {
                    x = 202,
                    y = 109,
                    w = 171,
                    h = 44,
                    action = {
                        "dialogue",
                        5
                    }
                }, 
                {
                    x = 0,
                    y = 0,
                    w = 83,
                    h = 55,
                    action = {
                        "dialogue",
                        7
                    }
                }, 
                {
                    x = 287,
                    y = 190,
                    w = 50,
                    h = 29,
                    action = {
                        "dialogue",
                        8
                    }
                }, 
                {
                    x = 118,
                    y = 170,
                    w = 115,
                    h = 102,
                    action = {
                        "move",
                        9
                    }
                },
            }
        },
        -- ID 9 - Under the hockey table
        {
            -- The room image to be displayed
            img = "assets/png/rooms/9.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                nil, 
                8, 
                nil,
            },
            interact = {
                {
                    x = 291,
                    y = 60,
                    w = 80,
                    h = 212,
                    action = {
                        "dialogue",
                        9
                    }
                }, 
                {
                    x = 432,
                    y = 145,
                    w = 48,
                    h = 127,
                    action = {
                        "dialogue",
                        9
                    }
                },
                {
                    x = 0,
                    y = 187,
                    w = 43,
                    h = 85,
                    action = {
                        "dialogue",
                        9
                    }
                },
                {
                    x = 152,
                    y = 215,
                    w = 27,
                    h = 57,
                    action = {
                        "dialogue",
                        10
                    }
                },
                {
                    x = 0,
                    y = 0,
                    w = 196,
                    h = 107,
                    action = {
                        "dialogue",
                        11
                    }
                },
                {
                    x = 391,
                    y = 47,
                    w = 37,
                    h = 46,
                    action = {
                        "dialogue",
                        8
                    }
                },
            }
        },
        -- ID 10 - Right lamp
        {
            -- The room image to be displayed
            img = "assets/png/rooms/10.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil,
            },
            interact = {
                {
                    x = 72,
                    y = 65,
                    w = 371,
                    h = 192,
                    action = {
                        "dialogue",
                        14
                    }
                }
            }
        },
        -- ID 11 -Left lamp
        {
            -- The room image to be displayed
            img = "assets/png/rooms/11.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil,
            },
            interact = {
                {
                    x = 72,
                    y = 65,
                    w = 371,
                    h = 192,
                    action = {
                        "dialogue",
                        14
                    }
                }
            }
        },
        -- ID 12 -Left lamp
        {
            -- The room image to be displayed
            img = "assets/png/rooms/12.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil,
            },
            interact = {
                {
                    x = 72,
                    y = 65,
                    w = 371,
                    h = 192,
                    action = {
                        "dialogue",
                        14
                    }
                }
            }
        },
        -- ID 13 -Left lamp
        {
            -- The room image to be displayed
            img = "assets/png/rooms/13.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil,
            },
            interact = {
                {
                    x = 72,
                    y = 65,
                    w = 371,
                    h = 192,
                    action = {
                        "dialogue",
                        14
                    }
                }
            }
        },
        -- ID 14 - Mirror
        {
            -- The room image to be displayed
            img = "assets/png/rooms/14.jpg",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                2, 
                nil, 
                nil,
            },
            interact = {
                {
                    x = 141,
                    y = 18,
                    w = 179,
                    h = 254,
                    action = {
                        "dialogue",
                        14
                    }
                },
                {
                    x = 321,
                    y = 70,
                    w = 28,
                    h = 25,
                    action = {
                        "move",
                        16
                    }
                },
            }
        },
        -- ID 15 -
        {
            -- The room image to be displayed
            img = "assets/png/rooms/15.png",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                1, 
                nil, 
                nil,
            },
            interact = {
                {
                    x = 72,
                    y = 65,
                    w = 371,
                    h = 192,
                    action = {
                        "dialogue",
                        14
                    }
                }
            }
        },
        -- ID 16 - Note on the mirror
        {
            -- The room image to be displayed
            img = "assets/png/rooms/361.jpg",
            load = 0,

            -- The directions that the player can move in:
            -- {canMove, roomID}
            canMove = {
                nil, 
                14, 
                nil, 
                nil,
            },
            interact = {}
        },
    }
}
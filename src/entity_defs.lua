ENTITY_DEFS = {
        ['skeleton'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='skeleton',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {22, 23, 24, 23},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {34, 35, 36, 35},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {10, 11, 12, 11},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {46, 47, 48, 47},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {23}
            },
            ['idle-right'] = {
                frames = {35}
            },
            ['idle-down'] = {
                frames = {11}
            },
            ['idle-up'] = {
                frames = {47}
            }
        }
    },
    ['slime'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='slime',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {61, 62, 63, 62},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {73, 74, 75, 74},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {49, 50, 51, 50},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {86, 86, 87, 86},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {62}
            },
            ['idle-right'] = {
                frames = {74}
            },
            ['idle-down'] = {
                frames = {50}
            },
            ['idle-up'] = {
                frames = {86}
            }
        }
    },
    ['bat'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='bat',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {64, 65, 66, 65},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {76, 77, 78, 77},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {52, 53, 54, 53},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {88, 89, 90, 89},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {64, 65, 66, 65},
                interval = 0.2
            },
            ['idle-right'] = {
                frames = {76, 77, 78, 77},
                interval = 0.2
            },
            ['idle-down'] = {
                frames = {52, 53, 54, 53},
                interval = 0.2
            },
            ['idle-up'] = {
                frames = {88, 89, 90, 89},
                interval = 0.2
            }
        }
    },
    ['ghost'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='ghost',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {67, 68, 69, 68},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {79, 80, 81, 80},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {55, 56, 57, 56},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {91, 92, 93, 92},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {68}
            },
            ['idle-right'] = {
                frames = {80}
            },
            ['idle-down'] = {
                frames = {56}
            },
            ['idle-up'] = {
                frames = {92}
            }
        }
    },
    ['spider'] = {
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='spider',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {70, 71, 72, 71},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {82, 83, 84, 83},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {58, 59, 60, 59},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {94, 95, 96, 95},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {71}
            },
            ['idle-right'] = {
                frames = {83}
            },
            ['idle-down'] = {
                frames = {59}
            },
            ['idle-up'] = {
                frames = {95}
            }
        }
    },
    ['girl']={
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='girl',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {19, 20, 21,20},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {31,32,33,32},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {7,8,9,8},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {43,44,45,44},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {20}
            },
            ['idle-right'] = {
                frames = {32}
            },
            ['idle-down'] = {
                frames = {8}
            },
            ['idle-up'] = {
                frames = {44}
            }
        }

    },
    ['boy']={
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='boy',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {16,17,18,17},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {28,29,30,29},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {4,5,6,5},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {40,41,42,41},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {17}
            },
            ['idle-right'] = {
                frames = {29}
            },
            ['idle-down'] = {
                frames = {5}
            },
            ['idle-up'] = {
                frames = {41}
            }
        }

    },
    ['cookie']={
        walkSpeed = PLAYER_WALK_SPEED,
        texture = 'entities',
        character='cookie',
        maxWidth = 16,
        height= 22,
        width = 16,
        animations = {
            ['walk-left'] = {
                frames = {13,14,15,14},
                interval = 0.2
            },
            ['walk-right'] = {
                frames = {25,26,27,26},
                interval = 0.2
            },
            ['walk-down'] = {
                frames = {1,2,3,2},
                interval = 0.2
            },
            ['walk-up'] = {
                frames = {37,38,39,38},
                interval = 0.2
            },
            ['idle-left'] = {
                frames = {14}
            },
            ['idle-right'] = {
                frames = {26}
            },
            ['idle-down'] = {
                frames = {2}
            },
            ['idle-up'] = {
                frames = {38}
            }
        }

    }
}
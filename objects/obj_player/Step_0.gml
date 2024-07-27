// Horizontal movement
hsp = 0;
if (keyboard_check(vk_left)) {
    hsp = -move_speed;
} else if (keyboard_check(vk_right)) {
    hsp = move_speed;
} else {
	hsp = 0;
}


// Apply horizontal movement
x += hsp;

// Apply gravity
if (!on_ground) {
    vsp += grv;
}

// Check for jumping
if (keyboard_check_pressed(vk_space) && on_ground) {
    vsp = jump_speed;
    on_ground = false;
}

// Apply vertical movement
y += vsp;


if (place_meeting(x, y + 1, obj_ground)) {
	on_ground = true;
	vsp = 0;      // Stop the downward movement
	
    // Adjust the player's position to be on top of the ground
    while (!place_meeting(x, y, obj_ground)) {
        y += 1;
    }
    y -= 1;
} else {
    on_ground = false;
}


//set sprite
mask_index = sprite[RIGHT];
if hsp > 0 {face = RIGHT};
if hsp < 0 {face = LEFT};

if hsp > 0 && face == LEFT {face = RIGHT};
if hsp < 0 && face == RIGHT {face = LEFT};
sprite_index = sprite[face];


// Ensure player stays within the game boundaries (optional)
if (x < 0) x = 0;
if (x > room_width - sprite_width) x = room_width - sprite_width;
if (y < 0) y = 0;
if (y > room_height - sprite_height) y = room_height - sprite_height;


//animate
if hsp == 0 && vsp == 0
{
image_index = 0;
}


//depth
depth = -bbox_bottom;

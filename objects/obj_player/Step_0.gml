function check_vertical_collisions() {
    if (vsp > 0) { // Falling
        if (place_meeting(x, y + vsp, obj_ground) || place_meeting(x, y + vsp, obj_block)) {
            while (!place_meeting(x, y + 1, obj_ground) && !place_meeting(x, y + 1, obj_block)) {
                y += 1;
            }
            y -= 1;
            vsp = 0;
            on_ground = true;
        }
    } else if (vsp < 0) { // Jumping
        if (place_meeting(x, y + vsp, obj_ground) || place_meeting(x, y + vsp, obj_block)) {
            while (!place_meeting(x, y - 1, obj_ground) && !place_meeting(x, y - 1, obj_block)) {
                y -= 1;
            }
            y += 1;
            vsp = 0;
        }
    }
}

function check_horizontal_collisions() {
    if (place_meeting(x + hsp, y, obj_ground) || place_meeting(x + hsp, y, obj_block)) {
        while (!place_meeting(x + sign(hsp), y, obj_ground) && !place_meeting(x + sign(hsp), y, obj_block)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
}

// Apply gravity
if (!on_ground) {
    vsp += grv;
}

// Horizontal movement
if (keyboard_check(vk_left)) {
    hsp = -move_speed;
} else if (keyboard_check(vk_right)) {
    hsp = move_speed;
} else {
	hsp = 0;
}

// Check for horizontal collisions
check_horizontal_collisions();

// Apply horizontal movement
x += hsp;

// Apply vertical movement and check for vertical collisions
y += vsp;
check_vertical_collisions();

// Check for jumping
if (keyboard_check_pressed(vk_space) && on_ground) {
    vsp = jump_speed;
    on_ground = false;
}

// Check if the player is still on the ground
if (!place_meeting(x, y + 1, obj_ground) && !place_meeting(x, y + 1, obj_block)) {
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
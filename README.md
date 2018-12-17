# ns2-community-fixes
A collection of fixes for NS2

The fixes are so far as follows:
* Cheats: Disables some cheaty console commands and ones that break the server
* CommanderSensor: makes sensor blips visible to commanders
* DamageIndicator: Fixes damage indicators so that different screen sizes don't react differently and also amplifies the animation
* DoorsByDragon: Fix by Dragon to make doors less glitchy
* Hallucinations: Make hallucinations "poof" instead of ragdoll
* Ladder: Makes climbing ladders faster and less glitchy
* Railgun: Allows shooting railguns into skyboxes
* Robotics: Fixes a rare crash related to building something at a robotics factory and then crashing/leaving the server
* Xenocide: Fix xenocide sometimes not dealing any damage
* OnosCrouch: Fix onos crouch exploit letting you see through walls
* ArmorFix: Round armor to nearest integer instead of rounding up
* Voting: Fix voting so that it accounts for players leaving the server and also allowing players to change their minds
* ForceEvenTeams: Fix force even teams vote to reset the game if a game is ongoing
* SetPoseParam: Works around a engine bug relating to spectating something that cannot set pose params
* IPSpawn: Spawns an extra Infantry Portal if a 9th player joins marines before reset votes are forbidden.
* SpecAliens: Alien vision now synchronizes for spectators when viewing a player from first person.
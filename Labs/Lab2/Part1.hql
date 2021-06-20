ACTUAL CODE THAT WORKS
----------------------


### LOADING OUR DATA IN ###

CREATE TABLE superheroes(
id INT,
name STRING,
Gender STRING,
EyeColor STRING,
Race STRING,
HairColor STRING,
Height INT,
Publisher STRING,
SkinColor STRING,
Alignment STRING,
Weight STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/superhero/heroes_information.csv' INTO TABLE superheroes;




CREATE TABLE heropowers(
hero_names STRING,
Agility STRING,
AcceleratedHealing STRING,
LanternPowerRing STRING,
DimensionalAwareness STRING,
ColdResistance STRING,
Durability STRING,
Stealth STRING,
EnergyAbsorption STRING,
Flight STRING,
DangerSense STRING,
Underwaterbreathing STRING,
Marksmanship STRING,
WeaponsMaster STRING,
PowerAugmentation STRING,
AnimalAttributes STRING,
Longevity STRING,
Intelligence STRING,
SuperStrength STRING,
Cryokinesis STRING,
Telepathy STRING,
EnergyArmor STRING,
EnergyBlasts STRING,
Duplication STRING,
SizeChanging STRING,
DensityControl STRING,
Stamina STRING,
AstralTravel STRING,
AudioControl STRING,
Dexterity STRING,
Omnitrix STRING,
SuperSpeed STRING,
Possession STRING,
AnimalOrientedPowers STRING,
WeaponbasedPowers STRING,
Electrokinesis STRING,
DarkforceManipulation STRING,
DeathTouch STRING,
Teleportation STRING,
EnhancedSenses STRING,
Telekinesis STRING,
EnergyBeams STRING,
Magic STRING,
Hyperkinesis STRING,
Jump STRING,
Clairvoyance STRING,
DimensionalTravel STRING,
PowerSense STRING,
Shapeshifting STRING,
PeakHumanCondition STRING,
Immortality STRING,
Camouflage STRING,
ElementControl STRING,
Phasing STRING,
AstralProjection STRING,
ElectricalTransport STRING,
FireControl STRING,
Projection STRING,
Summoning STRING,
EnhancedMemory STRING,
Reflexes STRING,
Invulnerability STRING,
EnergyConstructs STRING,
ForceFields STRING,
SelfSustenance STRING,
AntiGravity STRING,
Empathy STRING,
PowerNullifier STRING,
RadiationControl STRING,
PsionicPowers STRING,
Elasticity STRING,
SubstanceSecretion STRING,
ElementalTransmogrification STRING,
TechnopathCyberpath STRING,
PhotographicReflexes STRING,
SeismicPower STRING,
Animation STRING,
Precognition STRING,
MindControl STRING,
FireResistance STRING,
PowerAbsorption STRING,
EnhancedHearing STRING,
NovaForce STRING,
Insanity STRING,
Hypnokinesis STRING,
AnimalControl STRING,
NaturalArmor STRING,
Intangibility STRING,
EnhancedSight STRING,
MolecularManipulation STRING,
HeatGeneration STRING,
Adaptation STRING,
Gliding STRING,
PowerSuit STRING,
MindBlast STRING,
ProbabilityManipulation STRING,
GravityControl STRING,
Regeneration STRING,
LightControl STRING,
Echolocation STRING,
Levitation STRING,
ToxinandDiseaseControl STRING,
Banish STRING,
EnergyManipulation STRING,
HeatResistance STRING,
NaturalWeapons STRING,
TimeTravel STRING,
EnhancedSmell STRING,
Illusions STRING,
Thirstokinesis STRING,
HairManipulation STRING,
Illumination STRING,
Omnipotent STRING,
Cloaking STRING,
ChangingArmor STRING,
PowerCosmic STRING,
Biokinesis STRING,
WaterControl STRING,
RadiationImmunity STRING,
VisionTelescopic STRING,
ToxinandDiseaseResistance STRING,
SpatialAwareness STRING,
EnergyResistance STRING,
TelepathyResistance STRING,
MolecularCombustion STRING,
Omnilingualism STRING,
PortalCreation STRING,
Magnetism STRING,
MindControlResistance STRING,
PlantControl STRING,
Sonar STRING,
SonicScream STRING,
TimeManipulation STRING,
EnhancedTouch STRING,
MagicResistance STRING,
Invisibility STRING,
SubMariner STRING,
RadiationAbsorption STRING,
Intuitiveaptitude STRING,
VisionMicroscopic STRING,
Melting STRING,
WindControl STRING,
SuperBreath STRING,
Wallcrawling STRING,
VisionNight STRING,
VisionInfrared STRING,
GrimReaping STRING,
MatterAbsorption STRING,
TheForce STRING,
Resurrection STRING,
Terrakinesis STRING,
VisionHeat STRING,
Vitakinesis STRING,
RadarSense STRING,
QwardianPowerRing STRING,
WeatherControl STRING,
VisionXRay STRING,
VisionThermal STRING,
WebCreation STRING,
RealityWarping STRING,
OdinForce STRING,
SymbioteCostume STRING,
SpeedForce STRING,
PhoenixForce STRING,
MolecularDissipation STRING,
VisionCryo STRING,
Omnipresent STRING,
Omniscient STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/superhero/super_hero_powers.csv' INTO TABLE heropowers;

### TURNING POWERS INTO AN ARRAY ###

CREATE TABLE powers as SELECT hero_names, SPLIT(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(concat_ws(' ',
if(Agility == 'True', 'Agility', ''),
if(AcceleratedHealing == 'True', 'AcceleratedHealing', ''),
if(LanternPowerRing == 'True', 'LanternPowerRing', ''),
if(DimensionalAwareness == 'True', 'DimensionalAwareness', ''),
if(ColdResistance == 'True', 'ColdResistance', ''),
if(Durability == 'True', 'Durability', ''),
if(Stealth == 'True', 'Stealth', ''),
if(EnergyAbsorption == 'True', 'EnergyAbsorption', ''),
if(Flight == 'True', 'Flight', ''),
if(DangerSense == 'True', 'DangerSense', ''),
if(Underwaterbreathing == 'True', 'Underwaterbreathing', ''),
if(Marksmanship == 'True', 'Marksmanship', ''),
if(WeaponsMaster == 'True', 'WeaponsMaster', ''),
if(PowerAugmentation == 'True', 'PowerAugmentation', ''),
if(AnimalAttributes == 'True', 'AnimalAttributes', ''),
if(Longevity == 'True', 'Longevity', ''),
if(Intelligence == 'True', 'Intelligence', ''),
if(SuperStrength == 'True', 'SuperStrength', ''),
if(Cryokinesis == 'True', 'Cryokinesis', ''),
if(Telepathy == 'True', 'Telepathy', ''),
if(EnergyArmor == 'True', 'EnergyArmor', ''),
if(EnergyBlasts == 'True', 'EnergyBlasts', ''),
if(Duplication == 'True', 'Duplication', ''),
if(SizeChanging == 'True', 'SizeChanging', ''),
if(DensityControl == 'True', 'DensityControl', ''),
if(Stamina == 'True', 'Stamina', ''),
if(AstralTravel == 'True', 'AstralTravel', ''),
if(AudioControl == 'True', 'AudioControl', ''),
if(Dexterity == 'True', 'Dexterity', ''),
if(Omnitrix == 'True', 'Omnitrix', ''),
if(SuperSpeed == 'True', 'SuperSpeed', ''),
if(Possession == 'True', 'Possession', ''),
if(AnimalOrientedPowers == 'True', 'AnimalOrientedPowers', ''),
if(WeaponbasedPowers == 'True', 'WeaponbasedPowers', ''),
if(Electrokinesis == 'True', 'Electrokinesis', ''),
if(DarkforceManipulation == 'True', 'DarkforceManipulation', ''),
if(DeathTouch == 'True', 'DeathTouch', ''),
if(Teleportation == 'True', 'Teleportation', ''),
if(EnhancedSenses == 'True', 'EnhancedSenses', ''),
if(Telekinesis == 'True', 'Telekinesis', ''),
if(EnergyBeams == 'True', 'EnergyBeams', ''),
if(Magic == 'True', 'Magic', ''),
if(Hyperkinesis == 'True', 'Hyperkinesis', ''),
if(Jump == 'True', 'Jump', ''),
if(Clairvoyance == 'True', 'Clairvoyance', ''),
if(DimensionalTravel == 'True', 'DimensionalTravel', ''),
if(PowerSense == 'True', 'PowerSense', ''),
if(Shapeshifting == 'True', 'Shapeshifting', ''),
if(PeakHumanCondition == 'True', 'PeakHumanCondition', ''),
if(Immortality == 'True', 'Immortality', ''),
if(Camouflage == 'True', 'Camouflage', ''),
if(ElementControl == 'True', 'ElementControl', ''),
if(Phasing == 'True', 'Phasing', ''),
if(AstralProjection == 'True', 'AstralProjection', ''),
if(ElectricalTransport == 'True', 'ElectricalTransport', ''),
if(FireControl == 'True', 'FireControl', ''),
if(Projection == 'True', 'Projection', ''),
if(Summoning == 'True', 'Summoning', ''),
if(EnhancedMemory == 'True', 'EnhancedMemory', ''),
if(Reflexes == 'True', 'Reflexes', ''),
if(Invulnerability == 'True', 'Invulnerability', ''),
if(EnergyConstructs == 'True', 'EnergyConstructs', ''),
if(ForceFields == 'True', 'ForceFields', ''),
if(SelfSustenance == 'True', 'SelfSustenance', ''),
if(AntiGravity == 'True', 'AntiGravity', ''),
if(Empathy == 'True', 'Empathy', ''),
if(PowerNullifier == 'True', 'PowerNullifier', ''),
if(RadiationControl == 'True', 'RadiationControl', ''),
if(PsionicPowers == 'True', 'PsionicPowers', ''),
if(Elasticity == 'True', 'Elasticity', ''),
if(SubstanceSecretion == 'True', 'SubstanceSecretion', ''),
if(ElementalTransmogrification == 'True', 'ElementalTransmogrification', ''),
if(TechnopathCyberpath == 'True', 'TechnopathCyberpath', ''),
if(PhotographicReflexes == 'True', 'PhotographicReflexes', ''),
if(SeismicPower == 'True', 'SeismicPower', ''),
if(Animation == 'True', 'Animation', ''),
if(Precognition == 'True', 'Precognition', ''),
if(MindControl == 'True', 'MindControl', ''),
if(FireResistance == 'True', 'FireResistance', ''),
if(PowerAbsorption == 'True', 'PowerAbsorption', ''),
if(EnhancedHearing == 'True', 'EnhancedHearing', ''),
if(NovaForce == 'True', 'NovaForce', ''),
if(Insanity == 'True', 'Insanity', ''),
if(Hypnokinesis == 'True', 'Hypnokinesis', ''),
if(AnimalControl == 'True', 'AnimalControl', ''),
if(NaturalArmor == 'True', 'NaturalArmor', ''),
if(Intangibility == 'True', 'Intangibility', ''),
if(EnhancedSight == 'True', 'EnhancedSight', ''),
if(MolecularManipulation == 'True', 'MolecularManipulation', ''),
if(HeatGeneration == 'True', 'HeatGeneration', ''),
if(Adaptation == 'True', 'Adaptation', ''),
if(Gliding == 'True', 'Gliding', ''),
if(PowerSuit == 'True', 'PowerSuit', ''),
if(MindBlast == 'True', 'MindBlast', ''),
if(ProbabilityManipulation == 'True', 'ProbabilityManipulation', ''),
if(GravityControl == 'True', 'GravityControl', ''),
if(Regeneration == 'True', 'Regeneration', ''),
if(LightControl == 'True', 'LightControl', ''),
if(Echolocation == 'True', 'Echolocation', ''),
if(Levitation == 'True', 'Levitation', ''),
if(ToxinandDiseaseControl == 'True', 'ToxinandDiseaseControl', ''),
if(Banish == 'True', 'Banish', ''),
if(EnergyManipulation == 'True', 'EnergyManipulation', ''),
if(HeatResistance == 'True', 'HeatResistance', ''),
if(NaturalWeapons == 'True', 'NaturalWeapons', ''),
if(TimeTravel == 'True', 'TimeTravel', ''),
if(EnhancedSmell == 'True', 'EnhancedSmell', ''),
if(Illusions == 'True', 'Illusions', ''),
if(Thirstokinesis == 'True', 'Thirstokinesis', ''),
if(HairManipulation == 'True', 'HairManipulation', ''),
if(Illumination == 'True', 'Illumination', ''),
if(Omnipotent == 'True', 'Omnipotent', ''),
if(Cloaking == 'True', 'Cloaking', ''),
if(ChangingArmor == 'True', 'ChangingArmor', ''),
if(PowerCosmic == 'True', 'PowerCosmic', ''),
if(Biokinesis == 'True', 'Biokinesis', ''),
if(WaterControl == 'True', 'WaterControl', ''),
if(RadiationImmunity == 'True', 'RadiationImmunity', ''),
if(VisionTelescopic == 'True', 'VisionTelescopic', ''),
if(ToxinandDiseaseResistance == 'True', 'ToxinandDiseaseResistance', ''),
if(SpatialAwareness == 'True', 'SpatialAwareness', ''),
if(EnergyResistance == 'True', 'EnergyResistance', ''),
if(TelepathyResistance == 'True', 'TelepathyResistance', ''),
if(MolecularCombustion == 'True', 'MolecularCombustion', ''),
if(Omnilingualism == 'True', 'Omnilingualism', ''),
if(PortalCreation == 'True', 'PortalCreation', ''),
if(Magnetism == 'True', 'Magnetism', ''),
if(MindControlResistance == 'True', 'MindControlResistance', ''),
if(PlantControl == 'True', 'PlantControl', ''),
if(Sonar == 'True', 'Sonar', ''),
if(SonicScream == 'True', 'SonicScream', ''),
if(TimeManipulation == 'True', 'TimeManipulation', ''),
if(EnhancedTouch == 'True', 'EnhancedTouch', ''),
if(MagicResistance == 'True', 'MagicResistance', ''),
if(Invisibility == 'True', 'Invisibility', ''),
if(SubMariner == 'True', 'SubMariner', ''),
if(RadiationAbsorption == 'True', 'RadiationAbsorption', ''),
if(Intuitiveaptitude == 'True', 'Intuitiveaptitude', ''),
if(VisionMicroscopic == 'True', 'VisionMicroscopic', ''),
if(Melting == 'True', 'Melting', ''),
if(WindControl == 'True', 'WindControl', ''),
if(SuperBreath == 'True', 'SuperBreath', ''),
if(Wallcrawling == 'True', 'Wallcrawling', ''),
if(VisionNight == 'True', 'VisionNight', ''),
if(VisionInfrared == 'True', 'VisionInfrared', ''),
if(GrimReaping == 'True', 'GrimReaping', ''),
if(MatterAbsorption == 'True', 'MatterAbsorption', ''),
if(TheForce == 'True', 'TheForce', ''),
if(Resurrection == 'True', 'Resurrection', ''),
if(Terrakinesis == 'True', 'Terrakinesis', ''),
if(VisionHeat == 'True', 'VisionHeat', ''),
if(Vitakinesis == 'True', 'Vitakinesis', ''),
if(RadarSense == 'True', 'RadarSense', ''),
if(QwardianPowerRing == 'True', 'QwardianPowerRing', ''),
if(WeatherControl == 'True', 'WeatherControl', ''),
if(VisionXRay == 'True', 'VisionXRay', ''),
if(VisionThermal == 'True', 'VisionThermal', ''),
if(WebCreation == 'True', 'WebCreation', ''),
if(RealityWarping == 'True', 'RealityWarping', ''),
if(OdinForce == 'True', 'OdinForce', ''),
if(SymbioteCostume == 'True', 'SymbioteCostume', ''),
if(SpeedForce == 'True', 'SpeedForce', ''),
if(PhoenixForce == 'True', 'PhoenixForce', ''),
if(MolecularDissipation == 'True', 'MolecularDissipation', ''),
if(VisionCryo == 'True', 'VisionCryo', ''),
if(Omnipresent == 'True', 'Omnipresent', ''),
if(Omniscient == 'True', 'Omniscient', '')), 
'^\\s+', ''),
'\\s+$', ''),
'\\s+', ' '), 
' ') as powerarray
FROM heropowers;

### JOINING ###
CREATE TABLE superheroes2 AS SELECT a.*, b.powerarray FROM superheroes a JOIN powers b ON (a.name = b.hero_names);


CREATE TABLE intermediate
AS SELECT
name, 
map('gender', gender, 
'eyecolor', eyecolor,
'race', race,
'haircolor', haircolor,
'height', height,
'skincolor', skincolor,
'weight', weight) AS physical,
publisher,
alignment
FROM superheroes;


### FINAL TABLE ###

CREATE TABLE TheHeroes
AS SELECT a.*, b.powerarray
FROM intermediate a
JOIN superheroes2 b
ON (a.name = b.name);


### QUERIES ###

### QUESTION ONE, DISPLAY TALLEST SUPERHEROES ###
SELECT name, physical["height"] as height
FROM theheroes
ORDER BY height DESC LIMIT 10;


### QUESTION TWO, HEROES WHERE WE NEED TO ADD MISSING WEIGHT OR HEIGHT DATA ###
SELECT name, weight, height FROM superheroes WHERE ((weight=-99) OR (weight="") OR (height=-99) OR (height=""));

### QUESTION THREE, HOW MANY HEROES DOES EACH PUBLISHER HAVE? ###
SELECT publisher, COUNT(*)
FROM superheroes
GROUP BY publisher;

### QUETSION FOUR, HOW MANY DIFFERENT PUBLISHERS ARE THERE? ###
SELECT COUNT(DISTINCT publisher) FROM superheroes;

### QUESTION FIVE, WHAT IS MALE AND FEMALE REPRESENTATION ACROSS PUBLISHERS ###
select publisher,
sum(if(gender="Male", 1, 0)),
sum(if(gender="Female", 1, 0)),
sum(if(gender="Male", 1, 0)) / sum(if(gender="Male", 1, 1)) as maleness
from superheroes
GROUP BY publisher
sort by maleness asc;

### QUESTION SIX, LIST HEROES WITH MORE THAN FOUR POWERS ###
SELECT hero_names,
size(powerarray) AS numPowers
FROM powers
WHERE size(powerarray)>10 
SORT BY numPowers DESC;

### QUESTION SEVEN, HOW MANY HUMANS ARE GOOD? ###
select race, count(alignment="Good") as good from superheroes group by race;


### QUESTION EIGHT, CHARACTERS WHO ARE ONLY RACE OF THEIR KIND ###
select race, count(race) as cnt, collect_set(name) from superheroes group by race having cnt=1;

### QUESTION NINE, COUNT GOOD VS NEUTRAL VS BAD ###
select alignment, count(alignment) from superheroes group by alignment;

### QUESTION TEN, HEROES WHO HAVE THE SAME POWERS AS SOMEONE ELSE ###
select powerarray, count(powerarray) as cnt, collect_set(hero_names) from powers group by powerarray having cnt>1;


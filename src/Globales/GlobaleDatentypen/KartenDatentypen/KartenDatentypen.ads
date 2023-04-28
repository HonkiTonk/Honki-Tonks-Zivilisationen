package KartenDatentypen is
   pragma Pure;

   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldNatural is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is KartenfeldNatural range 1 .. KartenfeldNatural'Last;
   
   subtype Stadtfeld is KartenfeldPositiv range KartenfeldPositiv'First .. 20;
   
   -- Das hier kann vermutlich auch mal umgebaut/ersetzt/entfernt werden. äöü
   subtype SichtweiteNatural is KartenfeldNatural range KartenfeldNatural'First .. 10;
   -- Dafür auch mal einen subtype für die Einheitensichtweite einbauen? äöü
   subtype Sichtweite is SichtweiteNatural range 1 .. SichtweiteNatural'Last;
   
   -- Noch Umgebungsbereich von 0 .. X einbauen? äöü
   subtype UmgebungsbereichDrei is Kartenfeld range -3 .. 3;
   subtype UmgebungsbereichZwei is UmgebungsbereichDrei range -2 .. 2;
   subtype UmgebungsbereichEins is UmgebungsbereichZwei range -1 .. 1;
   
   
   
   -- Rückgabewert, Planeteninneres, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   type Ebene is new UmgebungsbereichDrei range -3 .. 2;
   subtype EbeneVorhanden is Ebene range -2 .. Ebene'Last;
   subtype EbenePlanet is EbeneVorhanden range EbeneVorhanden'First .. 0;
   subtype EbeneUnterflächeOberfläche is EbenePlanet range -1 .. 0;
   subtype EbeneOberfläche is EbeneVorhanden range 0 .. EbeneVorhanden'Last;
   subtype EbeneLuft is EbeneOberfläche range 1 .. EbeneVorhanden'Last;
   subtype EbenenbereichEins is EbeneVorhanden range EbeneVorhanden (UmgebungsbereichEins'First) .. EbeneVorhanden (UmgebungsbereichEins'Last);
   
   
   
   -- Bräuchte ich hier auch noch einen 7x7 Quadranten für die maximale Stadtumgebung oder kann ich das sparen? äöü
   type KartengeneratorQuadranten is range 1 .. 25;
   subtype StandardQuadranten is KartengeneratorQuadranten range 1 .. 4;

end KartenDatentypen;

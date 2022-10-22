pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartenDatentypen is

   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldNatural is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is KartenfeldNatural range 1 .. KartenfeldNatural'Last;
   
   subtype Stadtfeld is KartenfeldPositiv range KartenfeldPositiv'First .. 20;
   
   -- Das heir kann vermutlich auch mal umgebaut/ersetzt/entfernt werden. äöü
   subtype SichtweiteNatural is KartenfeldNatural range KartenfeldNatural'First .. 10;
   -- Dafür auch mal einen subtype für die Einheitensichtweite einbauen? äöü
   subtype Sichtweite is SichtweiteNatural range 1 .. SichtweiteNatural'Last;
   
   -- Noch Umgebungsbereich von 0 .. X einbauen? äöü
   subtype UmgebungsbereichDrei is Kartenfeld range -3 .. 3;
   subtype UmgebungsbereichZwei is UmgebungsbereichDrei range -2 .. 2;
   subtype UmgebungsbereichEins is UmgebungsbereichZwei range -1 .. 1;
   
   
   
   -- Achsen mal aufteilen. äöü
   -- type KartenfeldXAchse is new Kartenfeld;
   -- subtype KartenfeldMitNullXAchse is KartenfeldXAchse range KartenfeldXAchse (KartenfeldNatural'First) .. KartenfeldXAchse (KartenfeldNatural'Last);
   -- subtype KartenfeldPositivXAchse is KartenfeldMitNullXAchse range KartenfeldMitNullXAchse (KartenfeldPositiv'First) .. KartenfeldMitNullXAchse (KartenfeldPositiv'Last);
   -- subtype StadtfeldXAchse is KartenfeldPositivXAchse range KartenfeldPositivXAchse (Stadtfeld'First) .. KartenfeldPositivXAchse (Stadtfeld'Last);
   -- subtype SichtweiteMitNullXAchse is KartenfeldMitNullXAchse range KartenfeldMitNullXAchse (SichtweiteNatural'First) .. KartenfeldMitNullXAchse (SichtweiteNatural'Last);
   -- subtype SichtweiteXAchse is SichtweiteMitNullXAchse range SichtweiteMitNullXAchse (Sichtweite'First) .. SichtweiteMitNullXAchse (Sichtweite'Last);
   -- subtype UmgebungsbereichDreiXAchse is KartenfeldXAchse range KartenfeldXAchse (UmgebungsbereichDrei'First) .. KartenfeldXAchse (UmgebungsbereichDrei'Last);
   -- subtype UmgebungsbereichZweiXAchse is UmgebungsbereichDreiXAchse range UmgebungsbereichDreiXAchse (UmgebungsbereichZwei'First) .. UmgebungsbereichDreiXAchse (UmgebungsbereichZwei'Last);
   -- subtype UmgebungsbereichEinsXAchse is UmgebungsbereichZweiXAchse range UmgebungsbereichZweiXAchse (UmgebungsbereichEins'First) .. UmgebungsbereichZweiXAchse (UmgebungsbereichEins'Last);
   
   
   
   -- Rückgabewert, Planeteninneres, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit, Rückgabewert
   type Ebene is new UmgebungsbereichDrei range -3 .. 3;
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   subtype EbenePlanet is EbeneVorhanden range -2 .. 0;
   subtype EbeneLuft is EbeneVorhanden range 1 .. 2;
   subtype UmgebungsbereichDreiEAchse is Ebene;
   subtype UmgebungsbereichZweiEAchse is EbeneVorhanden;
   subtype UmgebungsbereichEinsEAchse is UmgebungsbereichZweiEAchse range UmgebungsbereichZweiEAchse (UmgebungsbereichEins'First) .. UmgebungsbereichZweiEAchse (UmgebungsbereichEins'Last);

end KartenDatentypen;

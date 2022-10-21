pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

-- Das hier nochmal weiter aufteilen? äöü
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
   
   -- Kann man das überhaupt sinnvoll einbauen? Müsste eventuell alle Funktionen/Prozeduren/Variablen/Records entsprechend anpassen, damit es immer eine Y- und XVariante gibt. äöü
   -- Alternative könnte man auch einen übergeordneten Typ erstellen und dann die beiden Achsen darauf basierend aufteilen, dann könnte man für allgemeine Sachen den Übertyp benutzen. äöü
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
   
   -- Wäre das nicht sinnvoller in ProduktionDatentypen? äöü
   type GesamteFeldbewertung is range 0 .. 750;
   subtype Einzelbewertung is GesamteFeldbewertung range 0 .. 10;
   
   type Bewertung_Enum is (
                           Null_Enum, Eins_Enum, Zwei_Enum, Drei_Enum, Vier_Enum, Fünf_Enum, Sechs_Enum, Sieben_Enum, Acht_Enum, Neun_Enum, Zehn_Enum
                          );
   pragma Ordered (Bewertung_Enum);
   
   

   -- Wäre das nicht sinnvoller in ProduktionDatentypen? äöü
   type Wirtschaft_Enum is (
                            Nahrung_Enum, Produktion_Enum, Geld_Enum, Forschung_Enum
                           );
   
   
   
   -- Wäre das nicht sinnvoller in KampfDatentypen? äöü
   type Kampf_Enum is (
                       Verteidigung_Enum, Angriff_Enum
                      );
   
   
   
   -- Das hier auch woanders hin? äöü
   type Auswahlbereich is range 0 .. 100;
   subtype AuswahlbereichVorhanden is Auswahlbereich range 1 .. Auswahlbereich'Last;

end KartenDatentypen;

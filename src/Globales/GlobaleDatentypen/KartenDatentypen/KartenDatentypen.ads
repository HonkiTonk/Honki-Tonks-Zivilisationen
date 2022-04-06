pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package KartenDatentypen is

   -- Das hier dann in KartenfeldYAchse umbenennen?
   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldPositivMitNullwert is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is KartenfeldPositivMitNullwert range 1 .. KartenfeldPositivMitNullwert'Last;
   subtype Stadtfeld is KartenfeldPositiv range KartenfeldPositiv'First .. 20;
   subtype SichtweiteMitNullwert is KartenfeldPositivMitNullwert range KartenfeldPositivMitNullwert'First .. 10;
   subtype Sichtweite is SichtweiteMitNullwert range 1 .. SichtweiteMitNullwert'Last;
   subtype UmgebungsbereichDrei is Kartenfeld range -3 .. 3;
   subtype UmgebungsbereichZwei is UmgebungsbereichDrei range -2 .. 2;
   subtype UmgebungsbereichEins is UmgebungsbereichZwei range -1 .. 1;
   
   ------------------ Eventuell mal zwei Kartenfeldertypen anlegen mit den gleichen Eigenschaften und eines für die YAchse und das Andere für die XAchse verwenden?
   -- Könnte Verwechslungen zwischen den beiden Achsen verringern/vermeiden und wenn es zu einer Gleichbenennung kommen würde, dann sollte es immer noch funktionieren weil die Datentypen ja unterschiedlich sind.
   type KartenfeldXAchse is new Kartenfeld;
   subtype KartenfeldPositivMitNullwertXAchse is KartenfeldXAchse range KartenfeldXAchse (KartenfeldPositivMitNullwert'First) .. KartenfeldXAchse (KartenfeldPositivMitNullwert'Last);
   subtype KartenfeldPositivXAchse is KartenfeldPositivMitNullwertXAchse range KartenfeldPositivMitNullwertXAchse (KartenfeldPositiv'First) .. KartenfeldPositivMitNullwertXAchse (KartenfeldPositiv'Last);
   subtype StadtfeldXAchse is KartenfeldPositivXAchse range KartenfeldPositivXAchse (Stadtfeld'First) .. KartenfeldPositivXAchse (Stadtfeld'Last);
   subtype SichtweiteMitNullwertXAchse is KartenfeldPositivMitNullwertXAchse range KartenfeldPositivMitNullwertXAchse (SichtweiteMitNullwert'First) .. KartenfeldPositivMitNullwertXAchse (SichtweiteMitNullwert'Last);
   subtype SichtweiteXAchse is SichtweiteMitNullwertXAchse range SichtweiteMitNullwertXAchse (Sichtweite'First) .. SichtweiteMitNullwertXAchse (Sichtweite'Last);
   subtype UmgebungsbereichDreiXAchse is KartenfeldXAchse range KartenfeldXAchse (UmgebungsbereichDrei'First) .. KartenfeldXAchse (UmgebungsbereichDrei'Last);
   subtype UmgebungsbereichZweiXAchse is UmgebungsbereichDreiXAchse range UmgebungsbereichDreiXAchse (UmgebungsbereichZwei'First) .. UmgebungsbereichDreiXAchse (UmgebungsbereichZwei'Last);
   subtype UmgebungsbereichEinsXAchse is UmgebungsbereichZweiXAchse range UmgebungsbereichZweiXAchse (UmgebungsbereichEins'First) .. UmgebungsbereichZweiXAchse (UmgebungsbereichEins'Last);
   
   -- Rückgabewert, Planeteninneres, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   subtype Ebene is UmgebungsbereichDrei range -3 .. 2;
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   
   type SichtbereichAnfangEndeArray is array (1 .. 4) of Kartenfeld;

   subtype Kartengröße_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Größe_20_20_Enum .. SystemDatentypen.Karte_Größe_Zufall_Enum;
   subtype Kartengröße_Verwendet_Enum is Kartengröße_Enum range SystemDatentypen.Karte_Größe_20_20_Enum .. SystemDatentypen.Karte_Größe_Nutzer_Enum;
   subtype Kartengröße_Standard_Enum is Kartengröße_Verwendet_Enum range SystemDatentypen.Karte_Größe_20_20_Enum .. SystemDatentypen.Karte_Größe_1000_1000_Enum;

   subtype Kartenart_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Art_Inseln_Enum .. SystemDatentypen.Karte_Art_Chaos_Enum;

   subtype Kartenform_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Form_X_Zylinder_Enum .. SystemDatentypen.Karte_Form_Tugel_Extrem_Enum;
   subtype Kartenform_Einstellbar_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_E_Achse_Kein_Übergang_Enum .. SystemDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum;
   subtype Kartenform_E_Achse_Einstellbar_Enum is Kartenform_Einstellbar_Enum range SystemDatentypen.Karte_E_Achse_Kein_Übergang_Enum .. SystemDatentypen.Karte_E_Achse_Übergang_Enum;
   subtype Kartenform_Y_Achse_Einstellbar_Enum is Kartenform_Einstellbar_Enum range SystemDatentypen.Karte_Y_Achse_Kein_Übergang_Enum .. SystemDatentypen.Karte_Y_Achse_Verschobener_Übergang_Enum;
   subtype Kartenform_X_Achse_Einstellbar_Enum is Kartenform_Einstellbar_Enum range SystemDatentypen.Karte_X_Achse_Kein_Übergang_Enum .. SystemDatentypen.Karte_X_Achse_Verschobener_Übergang_Enum;

   subtype Kartentemperatur_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Temperatur_Kalt_Enum .. SystemDatentypen.Karte_Temperatur_Wüste_Enum;

   subtype Kartenressourcen_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Ressource_Arm_Enum .. SystemDatentypen.Karte_Ressource_Überfluss_Enum;
   
   subtype Kartenpole_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karten_Pole_Keine .. SystemDatentypen.Karten_Pole_Beide;
   
   type GesamtbewertungFeld is range -100 .. 100;
   subtype BewertungFeld is GesamtbewertungFeld range -10 .. 10;

   type Wirtschaft_Enum is (Nahrung, Produktion, Geld, Forschung);
   type Kampf_Enum is (Verteidigung, Angriff);

end KartenDatentypen;

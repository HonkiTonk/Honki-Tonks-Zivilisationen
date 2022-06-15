pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartenDatentypen is

   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldNatural is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is KartenfeldNatural range 1 .. KartenfeldNatural'Last;
   subtype Stadtfeld is KartenfeldPositiv range KartenfeldPositiv'First .. 20;
   subtype SichtweiteNatural is KartenfeldNatural range KartenfeldNatural'First .. 10;
   subtype Sichtweite is SichtweiteNatural range 1 .. SichtweiteNatural'Last;
   subtype UmgebungsbereichDrei is Kartenfeld range -3 .. 3;
   subtype UmgebungsbereichZwei is UmgebungsbereichDrei range -2 .. 2;
   subtype UmgebungsbereichEins is UmgebungsbereichZwei range -1 .. 1;
   
   --------------------------- Kann man das überhaupt sinnvoll einbauen? Müsste eventuell alle Funktionen/Prozeduren/Variablen/Records entsprechend anpassen, damit es immer eine Y- und XVariante gibt.
   --------------------------- Alternative könnte man auch einen übergeordneten Typ erstellen und dann die beiden Achsen darauf basierend aufteilen, dann könnte man für allgemeine Sachen den Übertyp benutzen.
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
   subtype UmgebungsbereichDreiEAchse is Ebene;
   subtype UmgebungsbereichZweiEAchse is EbeneVorhanden;
   subtype UmgebungsbereichEinsEAchse is UmgebungsbereichZweiEAchse range UmgebungsbereichZweiEAchse (UmgebungsbereichEins'First) .. UmgebungsbereichZweiEAchse (UmgebungsbereichEins'Last);
   
   type SichtbereichAnfangEndeArray is array (1 .. 4) of Kartenfeld;
   
   
   
   -- Neue Kartengrößen immer zwischen 20 und 1.000 einfügen um Anpassungen in KartenDatentypen zu vermeiden, außer die minimale oder maximale Kartengröße soll verändert werden.
   type Kartengröße_Enum is (
                               Kartengröße_20_20_Enum, Kartengröße_40_40_Enum, Kartengröße_80_80_Enum, Kartengröße_120_80_Enum, Kartengröße_120_160_Enum, Kartengröße_160_160_Enum, Kartengröße_240_240_Enum,
                               Kartengröße_320_320_Enum, Kartengröße_1000_1000_Enum, Kartengröße_Nutzer_Enum, Kartengröße_Zufall_Enum
                              );
   pragma Ordered (Kartengröße_Enum);
   
   subtype Kartengröße_Verwendet_Enum is Kartengröße_Enum range Kartengröße_20_20_Enum .. Kartengröße_Nutzer_Enum;
   subtype Kartengröße_Standard_Enum is Kartengröße_Verwendet_Enum range Kartengröße_20_20_Enum .. Kartengröße_1000_1000_Enum;
                                
   
   
   type Kartenart_Enum is (
                           -- Normal
                           Kartenart_Inseln_Enum, Kartenart_Kontinente_Enum, Kartenart_Pangäa_Enum,
                           
                           -- Nutzerdefiniert
                           Kartenart_Nutzerdefiniert_Enum
                          );
   pragma Ordered (Kartenart_Enum);
   
   subtype Kartenart_Normal_Enum is Kartenart_Enum range Kartenart_Inseln_Enum .. Kartenart_Pangäa_Enum;
   
   -------------------------- Später umschreiben auf 
   -- type Kartenform_Enum is (
   --                         Kartenform_Kein_Übergang_Enum, Kartenform_Übergang_Enum, Kartenform_Rückwärts_Verschobener_Übergang_Enum, Kartenform_Verschobener_Übergang_Enum
   --                        ); 
   -- pragma Ordered (Kartenform_Enum);
   
   -- subtype Kartenform_Ebene_Enum is Kartenform_Enum range Kartenform_Kein_Übergang_Enum .. Kartenform_Übergang_Enum;
   -- Geht aktuell nicht weil dann größere Anpassungen im Kartenformmenü notwendig sind.
   
   type Kartenform_Enum is (
                            Karte_E_Kein_Übergang_Enum, Karte_E_Übergang_Enum,
                            Karte_Y_Kein_Übergang_Enum, Karte_Y_Übergang_Enum, Karte_Y_Rückwärts_Verschobener_Übergang_Enum, Karte_Y_Verschobener_Übergang_Enum,
                            Karte_X_Kein_Übergang_Enum, Karte_X_Übergang_Enum, Karte_X_Rückwärts_Verschobener_Übergang_Enum, Karte_X_Verschobener_Übergang_Enum
                           ); 
   pragma Ordered (Kartenform_Enum);
   
   subtype Kartenform_E_Einstellbar_Enum is Kartenform_Enum range Karte_E_Kein_Übergang_Enum .. Karte_E_Übergang_Enum;
   subtype Kartenform_Y_Einstellbar_Enum is Kartenform_Enum range Karte_Y_Kein_Übergang_Enum .. Karte_Y_Verschobener_Übergang_Enum;
   subtype Kartenform_X_Einstellbar_Enum is Kartenform_Enum range Karte_X_Kein_Übergang_Enum .. Karte_X_Verschobener_Übergang_Enum;
                     
   
   
   -- Neue Kartentemperaturen immer vor Wüste einfügen um Anpassungen in KartenDatentypen zu vermeiden.
   ------------------- Statt eines Enums einen Prozentwert von 0 bis 100 einbauen?
   type Kartentemperatur_Enum is (
                                  Kartentemperatur_Kalt_Enum, Kartentemperatur_Gemäßigt_Enum, Kartentemperatur_Heiß_Enum, Kartentemperatur_Eiszeit_Enum, Kartentemperatur_Wüste_Enum
                                 );
   pragma Ordered (Kartentemperatur_Enum);
   
   
                                
   -- Neue Kartenressorucen immer vor Überfluss einfügen um Anpassungen in KartenDatentypen zu vermeiden.
   type Kartenressourcen_Enum is (
                                  Kartenressourcen_Arm_Enum, Kartenressourcen_Wenig_Enum, Kartenressourcen_Mittel_Enum, Kartenressourcen_Viel_Enum, Kartenressourcen_Überfluss_Enum
                                 );
   pragma Ordered (Kartenressourcen_Enum);
   
   
   
   type Himmelsrichtungen_Enum is (
                                   Norden_Enum, Süden_Enum, Westen_Enum, Osten_Enum
                                  );
   
   type PolregionenArray is array (Himmelsrichtungen_Enum'Range) of KartenfeldNatural;
   
   
   
   type Kartenpole_Enum is (
                            Kartenpol_Nicht_Vorhanden_Enum, Kartenpol_Vorhanden_Enum
                           );
   pragma Ordered (Kartenpole_Enum);
   
   
   
   -------------------- Auch mal bessere Bereiche ermitteln/einbauen.
   type GesamteFeldbewertung is range 0 .. 1_250;
   subtype Einzelbewertung is GesamteFeldbewertung range 0 .. 10;

   type Wirtschaft_Enum is (
                            Nahrung, Produktion, Geld, Forschung
                           );
   
   type Kampf_Enum is (
                       Verteidigung, Angriff
                      );
   
   
   
   type WahrscheinlichkeitKartengenerator is range 0 .. 100;
   subtype WahrscheinlichkeitKartengeneratorVorhanden is WahrscheinlichkeitKartengenerator range 1 .. WahrscheinlichkeitKartengenerator'Last;

end KartenDatentypen;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartenDatentypen is

   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldNatural is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is KartenfeldNatural range 1 .. KartenfeldNatural'Last;
   
   subtype Stadtfeld is KartenfeldPositiv range KartenfeldPositiv'First .. 20;
   
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
   subtype UmgebungsbereichDreiEAchse is Ebene;
   subtype UmgebungsbereichZweiEAchse is EbeneVorhanden;
   subtype UmgebungsbereichEinsEAchse is UmgebungsbereichZweiEAchse range UmgebungsbereichZweiEAchse (UmgebungsbereichEins'First) .. UmgebungsbereichZweiEAchse (UmgebungsbereichEins'Last);
   
   type SichtbereichAnfangEndeArray is array (1 .. 4) of Kartenfeld;
                                
   
   
   type Kartenart_Enum is (
                           -- Normal
                           Kartenart_Inseln_Enum, Kartenart_Kontinente_Enum, Kartenart_Pangäa_Enum,
                           
                           -- Nutzerdefiniert
                           Kartenart_Nutzerdefiniert_Enum
                          );
   pragma Ordered (Kartenart_Enum);
   
   subtype Kartenart_Normal_Enum is Kartenart_Enum range Kartenart_Inseln_Enum .. Kartenart_Pangäa_Enum;
   
   
   
   type Kartenform_Enum is (
                            Karte_E_Kein_Übergang_Enum, Karte_E_Übergang_Enum,
                            Karte_Y_Kein_Übergang_Enum, Karte_Y_Übergang_Enum, Karte_Y_Rückwärts_Verschobener_Übergang_Enum, Karte_Y_Verschobener_Übergang_Enum,
                            Karte_X_Kein_Übergang_Enum, Karte_X_Übergang_Enum, Karte_X_Rückwärts_Verschobener_Übergang_Enum, Karte_X_Verschobener_Übergang_Enum
                           ); 
   pragma Ordered (Kartenform_Enum);
   
   subtype Kartenform_E_Einstellbar_Enum is Kartenform_Enum range Karte_E_Kein_Übergang_Enum .. Karte_E_Übergang_Enum;
   subtype Kartenform_Y_Einstellbar_Enum is Kartenform_Enum range Karte_Y_Kein_Übergang_Enum .. Karte_Y_Verschobener_Übergang_Enum;
   subtype Kartenform_X_Einstellbar_Enum is Kartenform_Enum range Karte_X_Kein_Übergang_Enum .. Karte_X_Verschobener_Übergang_Enum;
   
   -- Später umschreiben? auf äöü
   -- type Kartenform_Enum is (
   --                         Kartenform_Kein_Übergang_Enum, Kartenform_Übergang_Enum, Kartenform_Rückwärts_Verschobener_Übergang_Enum, Kartenform_Verschobener_Übergang_Enum
   --                        ); 
   -- pragma Ordered (Kartenform_Enum);
   
   -- subtype Kartenform_Ebene_Enum is Kartenform_Enum range Kartenform_Kein_Übergang_Enum .. Kartenform_Übergang_Enum;
   -- Geht aktuell nicht weil dann größere Anpassungen im Kartenformmenü notwendig sind.
   
   
   
   -- Neue Kartentemperaturen immer vor Wüste einfügen um Anpassungen in KartenDatentypen zu vermeiden.
   -- Statt eines Enums einen Zahlenwert von 0 bis 100 einbauen? äöü
   type Kartentemperatur_Enum is (
                                  Kartentemperatur_Kalt_Enum, Kartentemperatur_Gemäßigt_Enum, Kartentemperatur_Heiß_Enum, Kartentemperatur_Eiszeit_Enum, Kartentemperatur_Wüste_Enum
                                 );
   pragma Ordered (Kartentemperatur_Enum);
   
   
   
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
   
   
   
   type GesamteFeldbewertung is range 0 .. 1_250;
   subtype Einzelbewertung is GesamteFeldbewertung range 0 .. 10;

   type Wirtschaft_Enum is (
                            Nahrung, Produktion, Geld, Forschung
                           );
   
   type Kampf_Enum is (
                       Verteidigung, Angriff
                      );
   
   
   
   type Auswahlbereich is range 0 .. 100;
   subtype AuswahlbereichVorhanden is Auswahlbereich range 1 .. Auswahlbereich'Last;

end KartenDatentypen;

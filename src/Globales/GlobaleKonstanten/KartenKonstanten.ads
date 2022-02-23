pragma SPARK_Mode (On);

with SystemDatentypen;
with KartenRecords;
with SystemKonstanten;
with KartenDatentypen;
with EinheitStadtDatentypen;
with StadtKonstanten;

with DatenbankRecords;

package KartenKonstanten is
   
   -- Für Karteneinstellungen
   Kartengröße2020Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_20_20;
   Kartengröße4040Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_40_40;
   Kartengröße8080Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_80_80;
   Kartengröße12080Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_120_80;
   Kartengröße120160Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_120_160;
   Kartengröße160160Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_160_160;
   Kartengröße240240Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_240_240;
   Kartengröße320320Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_320_320;
   Kartengröße10001000Konstante : constant KartenDatentypen.Kartengröße_Standard_Enum := SystemDatentypen.Karte_Größe_1000_1000;
   KartengrößeNutzerKonstante : constant KartenDatentypen.Kartengröße_Verwendet_Enum := SystemDatentypen.Karte_Größe_Nutzer;
   KartengrößeZufallKonstante : constant KartenDatentypen.Kartengröße_Enum := SystemDatentypen.Karte_Größe_Zufall;
   
   KartenartInselnKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Inseln;
   KartenartKontinenteKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Kontinente;
   KartenartPangäaKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Pangäa;
   KartenartLandKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Nur_Land;
   KartenartChaosKonstante : constant KartenDatentypen.Kartenart_Verwendet_Enum := SystemDatentypen.Karte_Art_Chaos;
   
   KartenformXZylinderKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_X_Zylinder;
   KartenformYZylinderKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Y_Zylinder;
   KartenformTorusKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Torus;
   KartenformKugelKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Kugel;
   KartenformViereckKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Viereck;
   KartenformKugelGedrehtKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Kugel_Gedreht;
   KartenformTugelKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel;
   KartenformTugelGedrehtKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel_Gedreht;
   KartenformTugelExtremKonstante : constant KartenDatentypen.Kartenform_Verwendet_Enum := SystemDatentypen.Karte_Form_Tugel_Extrem;
   
   KartenformStandard : constant KartenRecords.KartenformRecord := (SystemDatentypen.Karte_E_Achse_Fest,
                                                                    SystemDatentypen.Karte_Y_Achse_Fest,
                                                                    SystemDatentypen.Karte_X_Achse_Normaler_Übergang);
   
   TemperaturKaltKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Kalt;
   TemperaturGemäßigtKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Gemäßigt;
   TemperaturHeißKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Heiß;
   TemperaturEiszeitKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Eiszeit;
   TemperaturWüsteKonstante : constant KartenDatentypen.Kartentemperatur_Verwendet_Enum := SystemDatentypen.Karte_Temperatur_Wüste;
   
   RessourcenArmKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Arm;
   RessourcenWenigKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Wenig;
   RessourcenMittelKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Mittel;
   RessourcenVielKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Viel;
   RessourcenÜberflussKonstante : constant KartenDatentypen.Kartenressourcen_Verwendet_Enum := SystemDatentypen.Karte_Ressource_Überfluss;
   -- Für Karteneinstellungen
   
   

   LeerEAchse : constant KartenDatentypen.Ebene := KartenDatentypen.Ebene'First;
   LeerYAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;
   LeerXAchse : constant KartenDatentypen.KartenfeldPositivMitNullwert := KartenDatentypen.KartenfeldPositivMitNullwert'First;

   LeerKartenKoordinaten : constant KartenRecords.AchsenKartenfeldPositivRecord := (EAchse => LeerEAchse,
                                                                                    YAchse => LeerYAchse,
                                                                                    XAchse => LeerXAchse);
   
   LeerKartenGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
   LeerPassierbarkeit : constant Boolean := False;
      
   LeerBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerWirtschaft : constant EinheitStadtDatentypen.ProduktionElement := 0;
   LeerKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;
   
   LeerKartenListe : constant DatenbankRecords.KartenListeRecord := (
                                                                     KartenGrafik   => LeerKartenGrafik,
                                                                     Passierbarkeit => (others => LeerPassierbarkeit),
                                                                     Bewertung      => (others => LeerBewertung),
                                                                     Wirtschaft     => (others => (others => LeerWirtschaft)),
                                                                     Kampf          => (others => (others => LeerKampf))
                                                                    );
   
   LeerGrund : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer_Grund;
   LeerHügel : constant Boolean := False;
   LeerSichtbar : constant Boolean := False;
   LeerFluss : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer_Grund;
   LeerVerbesserung : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer_Verbesserung;
   LeerVerbesserungWeg : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer_Verbesserung;
   LeerVerbesserungGebiet : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Leer_Verbesserung;
   LeerRessource : constant KartenDatentypen.Karten_Grund_Enum := KartenDatentypen.Leer_Grund;
   LeerDurchStadtBelegterGrund : constant KartenRecords.BelegterGrundRecord := (StadtKonstanten.LeerRasse, StadtKonstanten.LeerNummer);
   LeerFelderwertung : constant KartenDatentypen.GesamtbewertungFeld := 0;

   LeerWeltkarte : constant KartenRecords.KartenRecord := (
                                                           Grund                   => LeerGrund,
                                                           Hügel                   => LeerHügel,
                                                           Sichtbar                => (others => LeerSichtbar),
                                                           Fluss                   => LeerFluss,
                                                           VerbesserungWeg         => LeerVerbesserungWeg,
                                                           VerbesserungGebiet      => LeerVerbesserungGebiet,
                                                           Ressource               => LeerRessource,
                                                           DurchStadtBelegterGrund => LeerDurchStadtBelegterGrund,
                                                           Felderwertung           => (others => LeerFelderwertung)
                                                          );
   
   LeerVerbesserungGrafik : constant Wide_Wide_Character := SystemKonstanten.LeerZeichen;
      
   LeerVerbesserungBewertung : constant KartenDatentypen.BewertungFeld := 0;
   LeerVerbesserungWirtschaft : constant EinheitStadtDatentypen.ProduktionElement := 0;
   LeerVerbesserungKampf : constant EinheitStadtDatentypen.Kampfwerte := EinheitStadtDatentypen.Kampfwerte'First;

   LeerVerbesserungListe : constant DatenbankRecords.VerbesserungListeRecord := (
                                                                                 VerbesserungGrafik => LeerVerbesserungGrafik,
                                                                                 Passierbarkeit     => (others => LeerPassierbarkeit),
                                                                                 Bewertung          => (others => LeerVerbesserungBewertung),
                                                                                 Wirtschaft         => (others => (others => LeerVerbesserungWirtschaft)),
                                                                                 Kampf              => (others => (others => LeerVerbesserungKampf))
                                                                                );
   
   type EisgebietArray is array (KartenDatentypen.Kartengröße_Verwendet_Enum'Range) of KartenDatentypen.KartenfeldPositiv;
   Eisrand : constant EisgebietArray := (
                                         SystemDatentypen.Karte_Größe_20_20     => 1,
                                         SystemDatentypen.Karte_Größe_40_40     => 1,
                                         SystemDatentypen.Karte_Größe_80_80     => 2,
                                         SystemDatentypen.Karte_Größe_120_80    => 3,
                                         SystemDatentypen.Karte_Größe_120_160   => 3,
                                         SystemDatentypen.Karte_Größe_160_160   => 4,
                                         SystemDatentypen.Karte_Größe_240_240   => 6,
                                         SystemDatentypen.Karte_Größe_320_320   => 8,
                                         SystemDatentypen.Karte_Größe_1000_1000 => 24,
                                         SystemDatentypen.Karte_Größe_Nutzer    => 1
                                        );

   Eisschild : constant EisgebietArray := (
                                           SystemDatentypen.Karte_Größe_20_20     => 3,
                                           SystemDatentypen.Karte_Größe_40_40     => 3,
                                           SystemDatentypen.Karte_Größe_80_80     => 6,
                                           SystemDatentypen.Karte_Größe_120_80    => 9,
                                           SystemDatentypen.Karte_Größe_120_160   => 9,
                                           SystemDatentypen.Karte_Größe_160_160   => 12,
                                           SystemDatentypen.Karte_Größe_240_240   => 18,
                                           SystemDatentypen.Karte_Größe_320_320   => 24,
                                           SystemDatentypen.Karte_Größe_1000_1000 => 72,
                                           SystemDatentypen.Karte_Größe_Nutzer    => 1
                                          );
   
   WirtschaftNahrung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Nahrung;
   WirtschaftProduktion : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Produktion;
   WirtschaftGeld : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Geld;
   WirtschaftForschung : constant KartenDatentypen.Wirtschaft_Enum := KartenDatentypen.Forschung;
   KampfVerteidigung : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Verteidigung;
   KampfAngriff : constant KartenDatentypen.Kampf_Enum := KartenDatentypen.Angriff;
   
   -- Kartengrund
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Wasser;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Küstengewässer;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterwasser_Wasser;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterwasser_Küstengewässer;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Eis;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterwasser_Eis;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lava;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Planetenkern;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Tundra;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Wüste;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Hügel;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Gebirge;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Wald;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Dschungel;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Sumpf;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flachland;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Hügel_Mit;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Wolken;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Weltraum;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Erde;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Erdgestein;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Sand;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Gestein;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Korallen;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterwasser_Wald;
                              
   -- Ressourcen
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Fisch;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Wal;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Kohle;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Eisen;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Öl;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Hochwertiger_Boden;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Gold;
                              
   -- Fluss
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskreuzung_Vier;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Fluss_Waagrecht;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Fluss_Senkrecht;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskurve_Unten_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskurve_Unten_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskurve_Oben_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskurve_Oben_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskreuzung_Drei_Oben;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskreuzung_Drei_Unten;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskreuzung_Drei_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flusskreuzung_Drei_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flussendstück_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flussendstück_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flussendstück_Unten;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Flussendstück_Oben;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.See;
                              
   -- Unterirdischer Fluss
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Vier;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdischer_Fluss_Waagrecht;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdischer_Fluss_Senkrecht;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskurve_Unten_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskurve_Unten_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskurve_Oben_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskurve_Oben_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Oben;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Unten;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdische_Flusskreuzung_Drei_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Unten;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdisches_Flussendstück_Oben;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Unterirdischer_See;
                              
   -- Lavafluss
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskreuzung_Vier;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavafluss_Waagrecht;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavafluss_Senkrecht;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskurve_Unten_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskurve_Unten_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskurve_Oben_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskurve_Oben_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Oben;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Unten;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflusskreuzung_Drei_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflussendstück_Links;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflussendstück_Rechts;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflussendstück_Unten;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavaflussendstück_Oben;
   -- : constant KartenDatentypen.Karten_Verbesserung_Enum := KartenDatentypen.Lavasee;
   -- Kartengrund
   
   
   
   -- Kartenverbesserungen
   -- Städte
  --   Eigene_Hauptstadt, Eigene_Stadt,
  -- Fremde_Hauptstadt, Fremde_Stadt,
                                     
   -- Gebilde
  -- Farm, Mine,
  -- Festung, Sperre,
                                     
   -- Wege - Straßen
  -- Straßenkreuzung_Vier, Straße_Waagrecht, Straße_Senkrecht, Straßenkurve_Unten_Rechts, Straßenkurve_Unten_Links, Straßenkurve_Oben_Rechts, Straßenkurve_Oben_Links,
  -- Straßenkreuzung_Drei_Oben, Straßenkreuzung_Drei_Unten, Straßenkreuzung_Drei_Rechts, Straßenkreuzung_Drei_Links, Straßenendstück_Links, Straßenendstück_Rechts,
  -- Straßenendstück_Unten, Straßenendstück_Oben, Straße_Einzeln,
                                     
   -- Schienen
  -- Schienenkreuzung_Vier, Schiene_Waagrecht, Schiene_Senkrecht, Schienenkurve_Unten_Rechts, Schienenkurve_Unten_Links, Schienenkurve_Oben_Rechts, Schienenkurve_Oben_Links,
  -- Schienenkreuzung_Drei_Oben, Schienenkreuzung_Drei_Unten, Schienenkreuzung_Drei_Rechts, Schienenkreuzung_Drei_Links, Schienenendstück_Links, Schienenendstück_Rechts,
  -- Schienenendstück_Unten, Schienenendstück_Oben, Schiene_Einzeln,
                                     
   -- Tunnel
  -- Tunnelkreuzung_Vier, Tunnel_Waagrecht, Tunnel_Senkrecht, Tunnelkurve_Unten_Rechts, Tunnelkurve_Unten_Links, Tunnelkurve_Oben_Rechts, Tunnelkurve_Oben_Links,
  -- Tunnelkreuzung_Drei_Oben, Tunnelkreuzung_Drei_Unten, Tunnelkreuzung_Drei_Rechts, Tunnelkreuzung_Drei_Links, Tunnelendstück_Links, Tunnelendstück_Rechts,
  -- Tunnelendstück_Unten, Tunnelendstück_Oben, Tunnel_Einzeln
   -- Kartenverbesserungen

end KartenKonstanten;

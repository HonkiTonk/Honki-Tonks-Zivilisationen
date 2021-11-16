pragma SPARK_Mode (On);

with SystemDatentypen;

package KartenDatentypen is

   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldPositivMitNullwert is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is Kartenfeld range 1 .. KartenfeldPositivMitNullwert'Last;
   subtype Stadtfeld is KartenfeldPositiv range 1 .. 20;
   subtype SichtweiteMitNullwert is KartenfeldPositivMitNullwert range 0 .. 10;
   subtype Sichtweite is SichtweiteMitNullwert range 1 .. 10;
   subtype LoopRangeMinusEinsZuEins is Kartenfeld range -1 .. 1;
   subtype LoopRangeMinusZweiZuZwei is Kartenfeld range -2 .. 2;
   subtype LoopRangeMinusDreiZuDrei is Kartenfeld range -3 .. 3;
   
   -- Rückgabewert, Planeteninneres, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   subtype Ebene is LoopRangeMinusDreiZuDrei range -3 .. 2;
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   
   type SichtbereichAnfangEndeArray is array (1 .. 4) of Kartenfeld;

   subtype Kartengröße_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Größe_20_20 .. SystemDatentypen.Karte_Größe_Zufall;
   subtype Kartengröße_Verwendet_Enum is Kartengröße_Enum range SystemDatentypen.Karte_Größe_20_20 .. SystemDatentypen.Karte_Größe_Nutzer;
   subtype Kartengröße_Standard_Enum is Kartengröße_Verwendet_Enum range SystemDatentypen.Karte_Größe_20_20 .. SystemDatentypen.Karte_Größe_1000_1000;

   subtype Kartenart_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Art_Inseln .. SystemDatentypen.Karte_Art_Chaos;

   subtype Kartenform_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Form_X_Zylinder .. SystemDatentypen.Karte_Form_Tugel_Extrem;

   subtype Kartentemperatur_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Temperatur_Kalt .. SystemDatentypen.Karte_Temperatur_Wüste;

   subtype Kartenressourcen_Verwendet_Enum is SystemDatentypen.Rückgabe_Werte_Enum range SystemDatentypen.Karte_Ressource_Arm .. SystemDatentypen.Karte_Ressource_Überfluss;
   
   -- Immer dran denken, alle Flussarten am Schluss hinzufügen.
   type Karten_Grund_Enum is (Leer,
                              -- Feld
                              Wasser, Küstengewässer, Unterwasser_Wasser, Unterwasser_Küstengewässer,
                              Eis, Unterwasser_Eis,
                              Lava, Planetenkern,
                              Tundra, Wüste, Hügel, Gebirge, Wald, Dschungel, Sumpf, Flachland, Hügel_Mit, Wolken, Weltraum, Erde, Erdgestein, Sand, Gestein,
                              Korallen, Unterwasser_Wald,
                              -- Ressourcen
                              Fisch, Wal,
                              Kohle, Eisen, Öl, Hochwertiger_Boden, Gold,
                              -- Fluss
                              Flusskreuzung_Vier, Fluss_Waagrecht, Fluss_Senkrecht, Flusskurve_Unten_Rechts, Flusskurve_Unten_Links, Flusskurve_Oben_Rechts, Flusskurve_Oben_Links, Flusskreuzung_Drei_Oben,
                              Flusskreuzung_Drei_Unten, Flusskreuzung_Drei_Rechts, Flusskreuzung_Drei_Links, Flussendstück_Links, Flussendstück_Rechts, Flussendstück_Unten, Flussendstück_Oben, Fluss_Einzeln,
                              -- Unterirdischer Fluss
                              Unterirdische_Flusskreuzung_Vier, Unterirdischer_Fluss_Waagrecht, Unterirdischer_Fluss_Senkrecht, Unterirdische_Flusskurve_Unten_Rechts, Unterirdische_Flusskurve_Unten_Links,
                              Unterirdische_Flusskurve_Oben_Rechts, Unterirdische_Flusskurve_Oben_Links, Unterirdische_Flusskreuzung_Drei_Oben, Unterirdische_Flusskreuzung_Drei_Unten,
                              Unterirdische_Flusskreuzung_Drei_Rechts, Unterirdische_Flusskreuzung_Drei_Links, Unterirdisches_Flussendstück_Links, Unterirdisches_Flussendstück_Rechts,
                              Unterirdisches_Flussendstück_Unten, Unterirdisches_Flussendstück_Oben, Unterirdischer_Fluss_Einzeln,
                              -- Lavafluss
                              Lavaflusskreuzung_Vier, Lavafluss_Waagrecht, Lavafluss_Senkrecht, Lavaflusskurve_Unten_Rechts, Lavaflusskurve_Unten_Links, Lavaflusskurve_Oben_Rechts, Lavaflusskurve_Oben_Links,
                              Lavaflusskreuzung_Drei_Oben, Lavaflusskreuzung_Drei_Unten, Lavaflusskreuzung_Drei_Rechts, Lavaflusskreuzung_Drei_Links, Lavaflussendstück_Links, Lavaflussendstück_Rechts,
                              Lavaflussendstück_Unten, Lavaflussendstück_Oben, Lavafluss_Einzeln
                             );
   pragma Ordered (Karten_Grund_Enum);

   subtype Karten_Grund_Alle_Felder_Enum is Karten_Grund_Enum range Wasser .. Unterwasser_Wald;
   subtype Karten_Grund_Wasser_Mit_Eis_Enum is Karten_Grund_Alle_Felder_Enum range Wasser .. Unterwasser_Eis;
   subtype Karten_Grund_Wasser_Enum is Karten_Grund_Wasser_Mit_Eis_Enum range Wasser .. Unterwasser_Küstengewässer;
   subtype Karten_Grund_Land_Enum is Karten_Grund_Alle_Felder_Enum range Eis .. Gestein;
   subtype Karten_Grund_Land_Ohne_Eis_Enum is Karten_Grund_Land_Enum range Tundra .. Gestein;
   subtype Karten_Grund_Ressourcen_Enum is Karten_Grund_Enum range Fisch .. Gold;
   subtype Karten_Grund_Ressourcen_Wasser is Karten_Grund_Ressourcen_Enum range Karten_Grund_Ressourcen_Enum'First .. Wal;
   subtype Karten_Grund_Ressourcen_Land is Karten_Grund_Ressourcen_Enum range Kohle .. Karten_Grund_Ressourcen_Enum'Last;
   subtype Karten_Fluss_Enum is Karten_Grund_Enum range Flusskreuzung_Vier .. Karten_Grund_Enum'Last;
   subtype Karten_Grund_Fluss_Enum is Karten_Fluss_Enum range Flusskreuzung_Vier .. Fluss_Einzeln;
   subtype Karten_Grund_Unterirdischer_Fluss_Enum is Karten_Fluss_Enum range Unterirdische_Flusskreuzung_Vier .. Unterirdischer_Fluss_Einzeln;
   subtype Karten_Grund_Lavafluss_Enum is Karten_Fluss_Enum range Lavaflusskreuzung_Vier .. Lavafluss_Einzeln;
   subtype Landschaft_Wahrscheinlichkeit_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra .. Sumpf;
   
   -- Flachland muss hier immer am Schluss kommen, sonst geht der Kartengenerator kaputt!
   subtype Karten_Grund_Generator_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra .. Flachland;
   subtype Karten_Unterwasser_Generator_Enum is Karten_Grund_Alle_Felder_Enum range Korallen .. Unterwasser_Wald;

   

   -- Immer dran denken, alle Wegearten am Schluss hinzufügen.
   type Karten_Verbesserung_Enum is (Leer,
                                     -- Städte
                                     Eigene_Hauptstadt, Eigene_Stadt,
                                     Fremde_Hauptstadt, Fremde_Stadt,
                                     -- Gebilde
                                     Farm, Mine,
                                     Festung, Sperre,
                                     -- Wege - Straßen
                                     Straßenkreuzung_Vier, Straße_Waagrecht, Straße_Senkrecht, Straßenkurve_Unten_Rechts, Straßenkurve_Unten_Links, Straßenkurve_Oben_Rechts, Straßenkurve_Oben_Links,
                                     Straßenkreuzung_Drei_Oben, Straßenkreuzung_Drei_Unten, Straßenkreuzung_Drei_Rechts, Straßenkreuzung_Drei_Links, Straßenendstück_Links, Straßenendstück_Rechts,
                                     Straßenendstück_Unten, Straßenendstück_Oben, Straße_Einzeln,
                                     -- Schienen
                                     Schienenkreuzung_Vier, Schiene_Waagrecht, Schiene_Senkrecht, Schienenkurve_Unten_Rechts, Schienenkurve_Unten_Links, Schienenkurve_Oben_Rechts, Schienenkurve_Oben_Links,
                                     Schienenkreuzung_Drei_Oben, Schienenkreuzung_Drei_Unten, Schienenkreuzung_Drei_Rechts, Schienenkreuzung_Drei_Links, Schienenendstück_Links, Schienenendstück_Rechts,
                                     Schienenendstück_Unten, Schienenendstück_Oben, Schiene_Einzeln,
                                     -- Tunnel
                                     Tunnelkreuzung_Vier, Tunnel_Waagrecht, Tunnel_Senkrecht, Tunnelkurve_Unten_Rechts, Tunnelkurve_Unten_Links, Tunnelkurve_Oben_Rechts, Tunnelkurve_Oben_Links,
                                     Tunnelkreuzung_Drei_Oben, Tunnelkreuzung_Drei_Unten, Tunnelkreuzung_Drei_Rechts, Tunnelkreuzung_Drei_Links, Tunnelendstück_Links, Tunnelendstück_Rechts,
                                     Tunnelendstück_Unten, Tunnelendstück_Oben, Tunnel_Einzeln
                                    );

   subtype Karten_Verbesserung_Stadt_ID_Enum is Karten_Verbesserung_Enum range Leer .. Eigene_Stadt;
   subtype Karten_Verbesserung_Städte_Enum is Karten_Verbesserung_Enum range Eigene_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Eigene_Städte_Enum is Karten_Verbesserung_Städte_Enum range Eigene_Hauptstadt .. Eigene_Stadt;
   subtype Karten_Verbesserung_Fremde_Städte_Enum is Karten_Verbesserung_Städte_Enum range Fremde_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Gebilde_Enum is Karten_Verbesserung_Enum range Farm .. Sperre;
   subtype Karten_Verbesserung_Gebilde_Friedlich_Enum is Karten_Verbesserung_Gebilde_Enum range Farm .. Mine;
   subtype Karten_Verbesserung_Gebilde_Kampf_Enum is Karten_Verbesserung_Gebilde_Enum range Festung .. Sperre;
   subtype Karten_Weg_Enum is Karten_Verbesserung_Enum range Straßenkreuzung_Vier .. Karten_Verbesserung_Enum'Last;
   subtype Karten_Verbesserung_Weg_Enum is Karten_Weg_Enum range Straßenkreuzung_Vier .. Straße_Einzeln;
   subtype Karten_Verbesserung_Schiene_Enum is Karten_Weg_Enum range Schienenkreuzung_Vier .. Schiene_Einzeln;
   subtype Karten_Verbesserung_Tunnel_Enum is Karten_Weg_Enum range Tunnelkreuzung_Vier .. Tunnel_Einzeln;

   type SichtbarkeitArray is array (SystemDatentypen.Rassen_Verwendet_Enum'Range) of Boolean;

   type Besondere_Ressourcen_Enum is (Leer, Kohle);
   subtype Besondere_Ressourcen_Verwendet_Enum is Besondere_Ressourcen_Enum range Kohle .. Besondere_Ressourcen_Enum'Last;

   type Bewertung_Werte_Enum is (Wertigkeit, Nahrung, Produktion, Geld, Wissen, Verteidigung, Angriff);
   subtype Bonus_Werte_Enum is Bewertung_Werte_Enum range Nahrung .. Angriff;

end KartenDatentypen;

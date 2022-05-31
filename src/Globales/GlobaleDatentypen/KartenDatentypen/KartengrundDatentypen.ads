pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package KartengrundDatentypen is

   -------------------- Das hier muss mal neu sortiert und anschließend alles angepasst werden.
   type Kartengrund_Enum is (
                             Leer_Grund_Enum,
                             
                             -- Weltraum
                             Weltraum_Enum,
                              
                             -- Himmel
                             Wolken_Enum,
                              
                             -- Oberfläche
                             Eis_Enum,
                             Wasser_Enum, Küstengewässer_Enum,
                             Flachland_Enum, Wüste_Enum, Hügel_Enum, Gebirge_Enum, Tundra_Enum,
                             Wald_Enum, Dschungel_Enum, Sumpf_Enum,
                             
                             -- Unterfläche
                             Untereis_Enum,
                             Küstengrund_Enum,
                             Meeresgrund_Enum, Korallen_Enum, Unterwald_Enum,
                             Erde_Enum, Erdgestein_Enum, Sand_Enum, Gestein_Enum,
                              
                             -- Planeteninneres
                             Lava_Enum, Planetenkern_Enum,
                             Ringwoodit_Enum, Majorit_Enum, Perowskit_Enum, Magnesiowüstit_Enum,
                              
                             -- Sonstiges
                             Vernichtet_Enum
                            );
   pragma Ordered (Kartengrund_Enum);
   
   subtype Kartengrund_Vorhanden_Enum is Kartengrund_Enum range Weltraum_Enum .. Kartengrund_Enum'Last;
   
   -- Weltraum
   subtype Kartengrund_Weltraum_Enum is Kartengrund_Vorhanden_Enum range Weltraum_Enum .. Weltraum_Enum;
   
   -- Himmel
   subtype Kartengrund_Himmel_Enum is Kartengrund_Vorhanden_Enum range Wolken_Enum .. Wolken_Enum;
   
   -- Oberfläche
   subtype Kartengrund_Oberfläche_Enum is Kartengrund_Vorhanden_Enum range Eis_Enum .. Sumpf_Enum;
   
   subtype Kartengrund_Oberfläche_Eiswasser_Enum is Kartengrund_Oberfläche_Enum range Eis_Enum .. Küstengewässer_Enum;
   subtype Kartengrund_Oberfläche_Wasser_Enum is Kartengrund_Oberfläche_Eiswasser_Enum range Wasser_Enum .. Küstengewässer_Enum;
   
   subtype Kartengrund_Oberfläche_Land_Enum is Kartengrund_Oberfläche_Enum range Flachland_Enum .. Sumpf_Enum;
   
   subtype Kartengrund_Oberfläche_Basis_Enum is Kartengrund_Oberfläche_Land_Enum range Flachland_Enum .. Tundra_Enum;
   subtype Kartengrund_Oberfläche_Zusatz_Enum is Kartengrund_Oberfläche_Land_Enum range Wald_Enum .. Sumpf_Enum;
   
   -- Unterfläche
   subtype Kartengrund_Unterfläche_Enum is Kartengrund_Vorhanden_Enum range Untereis_Enum .. Gestein_Enum;
   subtype Kartengrund_Unterfläche_Eiswasser_Enum is Kartengrund_Unterfläche_Enum range Untereis_Enum .. Unterwald_Enum;
   subtype Kartengrund_Unterfläche_Wasser_Enum is Kartengrund_Unterfläche_Eiswasser_Enum range Küstengrund_Enum .. Unterwald_Enum;
   subtype Kartengrund_Unterfläche_Wasser_Variabel_Enum is Kartengrund_Unterfläche_Wasser_Enum range Meeresgrund_Enum .. Unterwald_Enum;
   subtype Kartengrund_Unterfläche_Land_Enum is Kartengrund_Unterfläche_Enum range Erde_Enum .. Gestein_Enum;
   
   -- Planeteinneres
   subtype Kartengrund_Kernfläche_Enum is Kartengrund_Vorhanden_Enum range Lava_Enum .. Magnesiowüstit_Enum;
   subtype Kartengrund_Kernfläche_Flüssig_Enum is Kartengrund_Kernfläche_Enum range Lava_Enum .. Planetenkern_Enum;
   subtype Kartengrund_Kernfläche_Fest_Enum is Kartengrund_Kernfläche_Enum range Ringwoodit_Enum .. Magnesiowüstit_Enum;
   
   -- Sonstiges
   subtype Kartengrund_Sonstiges_Enum is Kartengrund_Vorhanden_Enum range Vernichtet_Enum .. Vernichtet_Enum;
   
   
   
   ---------------------- Ressourcen für den Kern hinzufügen.
   type Karten_Ressourcen_Enum is (
                                   Leer_Ressource_Enum,
                                   
                                   -- Wasserressourcen
                                   Fisch_Enum, Wal_Enum,
                                   
                                   -- Landressourcen
                                   Kohle_Enum, Eisen_Enum, Öl_Enum, Hochwertiger_Boden_Enum, Gold_Enum
                                     
                                   -- Kernressourcen
                                   
                                  );
   pragma Ordered (Karten_Ressourcen_Enum);
   
   subtype Karten_Ressourcen_Vorhanden_Enum is Karten_Ressourcen_Enum range Fisch_Enum .. Karten_Ressourcen_Enum'Last;
   
   subtype Karten_Ressourcen_Wasser is Karten_Ressourcen_Vorhanden_Enum range Fisch_Enum .. Wal_Enum;
   subtype Karten_Ressourcen_Land is Karten_Ressourcen_Vorhanden_Enum range Kohle_Enum .. Gold_Enum;
   -- subtype Karten_Ressourcen_Kern is Karten_Ressourcen_Vorhanden_Enum range  .. ;
   -- subtype Karten_Ressourcen_Lava is Karten_Ressourcen_Vorhanden_Enum range  .. ;
   
   
   
   type Kartenfluss_Enum is (
                              Leer_Fluss_Enum,
                              
                              -- Fluss
                              Flusskreuzung_Vier_Enum, Fluss_Waagrecht_Enum, Fluss_Senkrecht_Enum, Flusskurve_Unten_Rechts_Enum, Flusskurve_Unten_Links_Enum, Flusskurve_Oben_Rechts_Enum, Flusskurve_Oben_Links_Enum,
                              Flusskreuzung_Drei_Oben_Enum, Flusskreuzung_Drei_Unten_Enum, Flusskreuzung_Drei_Rechts_Enum, Flusskreuzung_Drei_Links_Enum, Flussendstück_Links_Enum, Flussendstück_Rechts_Enum,
                              Flussendstück_Unten_Enum, Flussendstück_Oben_Enum, See_Enum,
                              
                              -- Unterirdischer Fluss
                              Unterirdische_Flusskreuzung_Vier_Enum, Unterirdischer_Fluss_Waagrecht_Enum, Unterirdischer_Fluss_Senkrecht_Enum, Unterirdische_Flusskurve_Unten_Rechts_Enum,
                              Unterirdische_Flusskurve_Unten_Links_Enum, Unterirdische_Flusskurve_Oben_Rechts_Enum, Unterirdische_Flusskurve_Oben_Links_Enum, Unterirdische_Flusskreuzung_Drei_Oben_Enum,
                              Unterirdische_Flusskreuzung_Drei_Unten_Enum, Unterirdische_Flusskreuzung_Drei_Rechts_Enum, Unterirdische_Flusskreuzung_Drei_Links_Enum, Unterirdisches_Flussendstück_Links_Enum,
                              Unterirdisches_Flussendstück_Rechts_Enum, Unterirdisches_Flussendstück_Unten_Enum, Unterirdisches_Flussendstück_Oben_Enum, Unterirdischer_See_Enum,
                              
                              -- Lavafluss
                              Lavaflusskreuzung_Vier_Enum, Lavafluss_Waagrecht_Enum, Lavafluss_Senkrecht_Enum, Lavaflusskurve_Unten_Rechts_Enum, Lavaflusskurve_Unten_Links_Enum, Lavaflusskurve_Oben_Rechts_Enum,
                              Lavaflusskurve_Oben_Links_Enum, Lavaflusskreuzung_Drei_Oben_Enum, Lavaflusskreuzung_Drei_Unten_Enum, Lavaflusskreuzung_Drei_Rechts_Enum, Lavaflusskreuzung_Drei_Links_Enum,
                              Lavaflussendstück_Links_Enum, Lavaflussendstück_Rechts_Enum, Lavaflussendstück_Unten_Enum, Lavaflussendstück_Oben_Enum, Lavasee_Enum
                             );
   pragma Ordered (Kartenfluss_Enum);
                              
   subtype Kartenfluss_Vorhanden_Enum is Kartenfluss_Enum range Flusskreuzung_Vier_Enum .. Kartenfluss_Enum'Last;
   
   subtype Kartenfluss_Oberfläche_Enum is Kartenfluss_Vorhanden_Enum range Flusskreuzung_Vier_Enum .. See_Enum;
   subtype Kartenfluss_Unterfläche_Enum is Kartenfluss_Vorhanden_Enum range Unterirdische_Flusskreuzung_Vier_Enum .. Unterirdischer_See_Enum;
   subtype Kartenfluss_Kern_Enum is Kartenfluss_Vorhanden_Enum range Lavaflusskreuzung_Vier_Enum .. Lavasee_Enum;

end KartengrundDatentypen;

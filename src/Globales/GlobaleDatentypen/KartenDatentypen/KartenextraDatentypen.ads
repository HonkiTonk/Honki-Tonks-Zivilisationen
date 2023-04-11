package KartenextraDatentypen is
   pragma Pure;
   
   -- Für das Zeug hier auch mal Konstanten anlegen um einen leichteren Austausch zu ermöglichen? äöü

   -- Ressourcen für den Kern hinzufügen. äöü
   type Ressourcen_Enum is (
                            Leer_Ressource_Enum,
                                   
                            -- Wasserressourcen
                            Fisch_Enum, Wal_Enum,
                            Hochwertiges_Holz_Enum,
                                   
                            -- Landressourcen
                            -- Diese Ressourcuen kann man aber auch im Wasser finden, mal anpassen. äöü
                            Kohle_Enum, Eisen_Enum, Öl_Enum, Hochwertiger_Boden_Enum, Gold_Enum
                                     
                            -- Kernressourcen
                                   
                           );
   pragma Ordered (Ressourcen_Enum);
   
   subtype Ressourcen_Vorhanden_Enum is Ressourcen_Enum range Ressourcen_Enum'Succ (Ressourcen_Enum'First) .. Ressourcen_Enum'Last;
   
   subtype Ressourcen_Oberfläche_Wasser_Enum is Ressourcen_Vorhanden_Enum range Fisch_Enum .. Wal_Enum;
   subtype Ressourcen_Oberfläche_Land_Enum is Ressourcen_Vorhanden_Enum range Hochwertiges_Holz_Enum .. Gold_Enum;
   
   subtype Ressourcen_Unterfläche_Wasser_Enum is Ressourcen_Vorhanden_Enum range Fisch_Enum .. Hochwertiges_Holz_Enum;
   subtype Ressourcen_Unterfläche_Land_Enum is Ressourcen_Vorhanden_Enum range Kohle_Enum .. Gold_Enum;
   
   
   
   type Fluss_Enum is (
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
   pragma Ordered (Fluss_Enum);
                              
   subtype Fluss_Vorhanden_Enum is Fluss_Enum range Fluss_Enum'Succ (Fluss_Enum'First) .. Fluss_Enum'Last;
   
   subtype Fluss_Oberfläche_Enum is Fluss_Vorhanden_Enum range Flusskreuzung_Vier_Enum .. See_Enum;
   subtype Fluss_Unterfläche_Enum is Fluss_Vorhanden_Enum range Unterirdische_Flusskreuzung_Vier_Enum .. Unterirdischer_See_Enum;
   subtype Fluss_Kernfläche_Enum is Fluss_Vorhanden_Enum range Lavaflusskreuzung_Vier_Enum .. Lavasee_Enum;
   
   type Flussarten_Enum is (Oberfläche_Fluss_Enum, Unterfläche_Fluss_Enum, Kernfläche_Fluss_Enum);

end KartenextraDatentypen;

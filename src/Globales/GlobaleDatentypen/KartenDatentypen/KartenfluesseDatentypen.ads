package KartenfluesseDatentypen is
   pragma Pure;
   
   type Fluss_Enum is (
                       Leer_Fluss_Enum,
                              
                       -- Fluss
                       Flusskreuzung_Vier_Enum, Fluss_Waagrecht_Enum, Fluss_Senkrecht_Enum, Flusskurve_Unten_Rechts_Enum, Flusskurve_Unten_Links_Enum, Flusskurve_Oben_Rechts_Enum, Flusskurve_Oben_Links_Enum,
                       Flusskreuzung_Drei_Oben_Enum, Flusskreuzung_Drei_Unten_Enum, Flusskreuzung_Drei_Rechts_Enum, Flusskreuzung_Drei_Links_Enum, Flussende_Links_Enum, Flussende_Rechts_Enum,
                       Flussende_Unten_Enum, Flussende_Oben_Enum, See_Enum,
                              
                       -- Unterirdischer Fluss
                       Unterirdische_Flusskreuzung_Vier_Enum, Unterirdischer_Fluss_Waagrecht_Enum, Unterirdischer_Fluss_Senkrecht_Enum, Unterirdische_Flusskurve_Unten_Rechts_Enum,
                       Unterirdische_Flusskurve_Unten_Links_Enum, Unterirdische_Flusskurve_Oben_Rechts_Enum, Unterirdische_Flusskurve_Oben_Links_Enum, Unterirdische_Flusskreuzung_Drei_Oben_Enum,
                       Unterirdische_Flusskreuzung_Drei_Unten_Enum, Unterirdische_Flusskreuzung_Drei_Rechts_Enum, Unterirdische_Flusskreuzung_Drei_Links_Enum, Unterirdisches_Flussende_Links_Enum,
                       Unterirdisches_Flussende_Rechts_Enum, Unterirdisches_Flussende_Unten_Enum, Unterirdisches_Flussende_Oben_Enum, Unterirdischer_See_Enum,
                              
                       -- Lavafluss
                       Lavaflusskreuzung_Vier_Enum, Lavafluss_Waagrecht_Enum, Lavafluss_Senkrecht_Enum, Lavaflusskurve_Unten_Rechts_Enum, Lavaflusskurve_Unten_Links_Enum, Lavaflusskurve_Oben_Rechts_Enum,
                       Lavaflusskurve_Oben_Links_Enum, Lavaflusskreuzung_Drei_Oben_Enum, Lavaflusskreuzung_Drei_Unten_Enum, Lavaflusskreuzung_Drei_Rechts_Enum, Lavaflusskreuzung_Drei_Links_Enum,
                       Lavaflussende_Links_Enum, Lavaflussende_Rechts_Enum, Lavaflussende_Unten_Enum, Lavaflussende_Oben_Enum, Lavasee_Enum
                      );
   pragma Ordered (Fluss_Enum);
                              
   subtype Fluss_Vorhanden_Enum is Fluss_Enum range Fluss_Enum'Succ (Fluss_Enum'First) .. Fluss_Enum'Last;
   
   subtype Fluss_Oberfläche_Enum is Fluss_Vorhanden_Enum range Flusskreuzung_Vier_Enum .. See_Enum;
   subtype Fluss_Unterfläche_Enum is Fluss_Vorhanden_Enum range Unterirdische_Flusskreuzung_Vier_Enum .. Unterirdischer_See_Enum;
   subtype Fluss_Kernfläche_Enum is Fluss_Vorhanden_Enum range Lavaflusskreuzung_Vier_Enum .. Lavasee_Enum;
   
   type Flussarten_Enum is (Oberfläche_Fluss_Enum, Unterfläche_Fluss_Enum, Kernfläche_Fluss_Enum);

end KartenfluesseDatentypen;

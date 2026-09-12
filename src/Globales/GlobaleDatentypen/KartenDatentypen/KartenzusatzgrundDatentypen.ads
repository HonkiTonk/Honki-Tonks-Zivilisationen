package KartenzusatzgrundDatentypen is
   pragma Pure;
   
   -- Man könnte bei der Oberfläche Riffe mit einbauen, aber wie ist das dann Unterwasser? Sollte die da nicht auch vorhanden sein? äöü
   type Zusatzgrund_Enum is (
                             Leer_Zusatzgrund_Enum,
                             
                             -- Orbit
                              
                             -- Himmel
                              
                             -- Oberfläche
                             Waldkreuzung_Vier_Enum, Wald_Waagrecht_Enum, Wald_Senkrecht_Enum, Waldkurve_Unten_Rechts_Enum, Waldkurve_Unten_Links_Enum, Waldkurve_Oben_Rechts_Enum, Waldkurve_Oben_Links_Enum,
                             Waldkreuzung_Drei_Oben_Enum, Waldkreuzung_Drei_Unten_Enum, Waldkreuzung_Drei_Rechts_Enum, Waldkreuzung_Drei_Links_Enum, Waldende_Links_Enum, Waldende_Rechts_Enum,
                             Waldende_Unten_Enum, Waldende_Oben_Enum, Wald_Enum,
                             
                             Dschungelkreuzung_Vier_Enum, Dschungel_Waagrecht_Enum, Dschungel_Senkrecht_Enum, Dschungelkurve_Unten_Rechts_Enum, Dschungelkurve_Unten_Links_Enum, Dschungelkurve_Oben_Rechts_Enum,
                             Dschungelkurve_Oben_Links_Enum, Dschungelkreuzung_Drei_Oben_Enum, Dschungelkreuzung_Drei_Unten_Enum, Dschungelkreuzung_Drei_Rechts_Enum, Dschungelkreuzung_Drei_Links_Enum,
                             Dschungelende_Links_Enum, Dschungelende_Rechts_Enum, Dschungelende_Unten_Enum, Dschungelende_Oben_Enum, Dschungel_Enum,
                             
                             Sumpfkreuzung_Vier_Enum, Sumpf_Waagrecht_Enum, Sumpf_Senkrecht_Enum, Sumpfkurve_Unten_Rechts_Enum, Sumpfkurve_Unten_Links_Enum, Sumpfkurve_Oben_Rechts_Enum, Sumpfkurve_Oben_Links_Enum,
                             Sumpfkreuzung_Drei_Oben_Enum, Sumpfkreuzung_Drei_Unten_Enum, Sumpfkreuzung_Drei_Rechts_Enum, Sumpfkreuzung_Drei_Links_Enum, Sumpfende_Links_Enum, Sumpfende_Rechts_Enum,
                             Sumpfende_Unten_Enum, Sumpfende_Oben_Enum, Sumpf_Enum,
                             
                             -- Unterfläche
                             Korallenkreuzung_Vier_Enum, Korallen_Waagrecht_Enum, Korallen_Senkrecht_Enum, Korallenkurve_Unten_Rechts_Enum, Korallenkurve_Unten_Links_Enum, Korallenkurve_Oben_Rechts_Enum,
                             Korallenkurve_Oben_Links_Enum, Korallenkreuzung_Drei_Oben_Enum, Korallenkreuzung_Drei_Unten_Enum, Korallenkreuzung_Drei_Rechts_Enum, Korallenkreuzung_Drei_Links_Enum,
                             Korallenende_Links_Enum, Korallenende_Rechts_Enum, Korallenende_Unten_Enum, Korallenende_Oben_Enum, Korallen_Enum,
                             
                             Unterwaldkreuzung_Vier_Enum, Unterwald_Waagrecht_Enum, Unterwald_Senkrecht_Enum, Unterwaldkurve_Unten_Rechts_Enum, Unterwaldkurve_Unten_Links_Enum, Unterwaldkurve_Oben_Rechts_Enum,
                             Unterwaldkurve_Oben_Links_Enum, Unterwaldkreuzung_Drei_Oben_Enum, Unterwaldkreuzung_Drei_Unten_Enum, Unterwaldkreuzung_Drei_Rechts_Enum, Unterwaldkreuzung_Drei_Links_Enum,
                             Unterwaldende_Links_Enum, Unterwaldende_Rechts_Enum, Unterwaldende_Unten_Enum, Unterwaldende_Oben_Enum, Unterwald_Enum
                              
                             -- Planetenkern
                             
                            );
   pragma Ordered (Zusatzgrund_Enum);
   
   subtype Zusatzgrund_Vorhanden_Enum is Zusatzgrund_Enum range Zusatzgrund_Enum'Succ (Zusatzgrund_Enum'First) .. Zusatzgrund_Enum'Last;
   
   -- Orbit
   
   
   -- Himmel
   
   
   -- Oberfläche
   subtype Zusatzgrund_Oberfläche_Enum is Zusatzgrund_Vorhanden_Enum range Waldkreuzung_Vier_Enum .. Sumpf_Enum;
   
   subtype Zusatzgrund_Wald_Enum is Zusatzgrund_Oberfläche_Enum range Waldkreuzung_Vier_Enum .. Wald_Enum;
   subtype Zusatzgrund_Dschungel_Enum is Zusatzgrund_Oberfläche_Enum range Dschungelkreuzung_Vier_Enum .. Dschungel_Enum;
   subtype Zusatzgrund_Sumpf_Enum is Zusatzgrund_Oberfläche_Enum range Sumpfkreuzung_Vier_Enum .. Sumpf_Enum;
   
   -- Unterfläche
   subtype Zusatzgrund_Unterfläche_Enum is Zusatzgrund_Vorhanden_Enum range Korallenkreuzung_Vier_Enum .. Unterwald_Enum;
   
   subtype Zusatzgrund_Korallen_Enum is Zusatzgrund_Unterfläche_Enum range Korallenkreuzung_Vier_Enum .. Korallen_Enum;
   subtype Zusatzgrund_Unterwald_Enum is Zusatzgrund_Unterfläche_Enum range Unterwaldkreuzung_Vier_Enum .. Unterwald_Enum;
   
   -- Planeteinneres
   

end KartenzusatzgrundDatentypen;

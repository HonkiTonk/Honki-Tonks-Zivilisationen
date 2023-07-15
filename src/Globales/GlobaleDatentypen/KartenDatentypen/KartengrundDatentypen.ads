package KartengrundDatentypen is
   pragma Pure;
   
   -- Es sind immer 16 Elemente bei den Mehrfachmöglichkeiten.
  
   -- Alle nötigen Möglichkeiten ergeben 29 Elemente, sollte ich diese auch einbauen? äöü
   -- Bräuchte dann auch noch Extrabasisgrund für den Übergangsbereich zu allen anderen Gründen, inklusive Wasser. äöü
   
   type Basisgrund_Enum is (
                            Leer_Basisgrund_Enum,
                             
                            -- Weltraum
                            Weltraum_Enum,
                              
                            -- Himmel
                            Wolken_Enum,
                              
                            -- Oberfläche
                            Eis_Enum,
                            Wasser_Enum, Küstengewässer_Enum,
                            Flachland_Enum, Wüste_Enum, Tundra_Enum,
                            
                            Hügelkreuzung_Vier_Enum, Hügel_Waagrecht_Enum, Hügel_Senkrecht_Enum, Hügelkurve_Unten_Rechts_Enum, Hügelkurve_Unten_Links_Enum, Hügelkurve_Oben_Rechts_Enum, Hügelkurve_Oben_Links_Enum,
                            Hügelkreuzung_Drei_Oben_Enum, Hügelkreuzung_Drei_Unten_Enum, Hügelkreuzung_Drei_Rechts_Enum, Hügelkreuzung_Drei_Links_Enum, Hügelende_Links_Enum, Hügelende_Rechts_Enum,
                            Hügelende_Unten_Enum, Hügelende_Oben_Enum, Hügel_Enum,
                            
                            Gebirgekreuzung_Vier_Enum, Gebirge_Waagrecht_Enum, Gebirge_Senkrecht_Enum, Gebirgekurve_Unten_Rechts_Enum, Gebirgekurve_Unten_Links_Enum, Gebirgekurve_Oben_Rechts_Enum,
                            Gebirgekurve_Oben_Links_Enum, Gebirgekreuzung_Drei_Oben_Enum, Gebirgekreuzung_Drei_Unten_Enum, Gebirgekreuzung_Drei_Rechts_Enum, Gebirgekreuzung_Drei_Links_Enum,
                            Gebirgeende_Links_Enum, Gebirgeende_Rechts_Enum, Gebirgeende_Unten_Enum, Gebirgeende_Oben_Enum, Gebirge_Enum,
                            
                            -- Unterfläche
                            Untereis_Enum,
                            Küstengrund_Enum, Meeresgrund_Enum,
                            Erde_Enum, Erdgestein_Enum, Sand_Enum, Gestein_Enum,
                              
                            -- Planetenkern
                            Planetenkern_Enum, Lava_Enum,
                            Ringwoodit_Enum, Majorit_Enum, Perowskit_Enum, Magnesiowüstit_Enum,
                              
                            -- Sonstiges
                            Vernichtet_Enum
                           );
   pragma Ordered (Basisgrund_Enum);
      
   subtype Basisgrund_Vorhanden_Enum is Basisgrund_Enum range Basisgrund_Enum'Succ (Basisgrund_Enum'First) .. Basisgrund_Enum'Last;
   
   -- Weltraum
   subtype Basisgrund_Weltraum_Enum is Basisgrund_Vorhanden_Enum range Weltraum_Enum .. Weltraum_Enum;
   
   -- Himmel
   subtype Basisgrund_Himmel_Enum is Basisgrund_Vorhanden_Enum range Wolken_Enum .. Wolken_Enum;
   
   -- Oberfläche
   subtype Basisgrund_Oberfläche_Enum is Basisgrund_Vorhanden_Enum range Eis_Enum .. Gebirge_Enum;
   
   subtype Basisgrund_Oberfläche_Eiswasser_Enum is Basisgrund_Oberfläche_Enum range Eis_Enum .. Küstengewässer_Enum;
   subtype Basisgrund_Oberfläche_Wasser_Enum is Basisgrund_Oberfläche_Eiswasser_Enum range Wasser_Enum .. Küstengewässer_Enum;
   
   subtype Basisgrund_Oberfläche_Land_Enum is Basisgrund_Oberfläche_Enum range Flachland_Enum .. Gebirge_Enum;
   
   subtype Basisgrund_Flachland_Enum is Basisgrund_Oberfläche_Land_Enum range Flachland_Enum .. Flachland_Enum;
   subtype Basisgrund_Wüste_Enum is Basisgrund_Oberfläche_Land_Enum range Wüste_Enum .. Wüste_Enum;
   subtype Basisgrund_Tundra_Enum is Basisgrund_Oberfläche_Land_Enum range Tundra_Enum .. Tundra_Enum;
   subtype Basisgrund_Hügel_Enum is Basisgrund_Oberfläche_Land_Enum range Hügelkreuzung_Vier_Enum .. Hügel_Enum;
   subtype Basisgrund_Gebirge_Enum is Basisgrund_Oberfläche_Land_Enum range Gebirgekreuzung_Vier_Enum .. Gebirge_Enum;
   
   -- Unterfläche
   subtype Basisgrund_Unterfläche_Enum is Basisgrund_Vorhanden_Enum range Untereis_Enum .. Gestein_Enum;
   
   subtype Basisgrund_Unterfläche_Eiswasser_Enum is Basisgrund_Unterfläche_Enum range Untereis_Enum .. Meeresgrund_Enum;
   subtype Basisgrund_Unterfläche_Wasser_Enum is Basisgrund_Unterfläche_Eiswasser_Enum range Küstengrund_Enum .. Meeresgrund_Enum;
   
   subtype Basisgrund_Unterfläche_Land_Enum is Basisgrund_Unterfläche_Enum range Erde_Enum .. Gestein_Enum;
   
   -- Planeteinneres
   subtype Basisgrund_Kernfläche_Enum is Basisgrund_Vorhanden_Enum range Planetenkern_Enum .. Magnesiowüstit_Enum;
   subtype Basisgrund_Kernfläche_Flüssig_Enum is Basisgrund_Kernfläche_Enum range Planetenkern_Enum .. Lava_Enum;
   
   subtype Basisgrund_Kernfläche_Fest_Enum is Basisgrund_Kernfläche_Enum range Ringwoodit_Enum .. Magnesiowüstit_Enum;
   
   -- Sonstiges
   subtype Basisgrund_Sonstiges_Enum is Basisgrund_Vorhanden_Enum range Vernichtet_Enum .. Vernichtet_Enum;
   
   
   
   -- Man könnte bei der Oberfläche Riffe mit einbauen, aber wie ist das dann Unterwasser? Sollte die da nicht auch vorhanden sein? äöü
   type Zusatzgrund_Enum is (
                             Leer_Zusatzgrund_Enum,
                             
                             -- Weltraum
                              
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
   
   -- Weltraum
   
   
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
   

end KartengrundDatentypen;

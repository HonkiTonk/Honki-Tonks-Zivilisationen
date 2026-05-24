package StadtDatentypen is
   pragma Pure;

   -- Für Gebäude
   -- Hier mal auf GebäudeID und GebäudeIDVorhanden umschreiben. äöü
   type GebäudeIDBasis is range 0 .. 27;
   subtype GebäudeIDVorhanden is GebäudeIDBasis range 1 .. GebäudeIDBasis'Last;
   
   

   type Gebäude_Spezielle_Eigenschaften_Enum is (
                                                  Leer_Gebäude_Spezielle_Egienschaft_Enum,
                                                  
                                                  Eigenschaft_Enum
                                                 );
   
   subtype Gebäude_Spezielle_Eigenschaften_Verwendet_Enum
     is Gebäude_Spezielle_Eigenschaften_Enum range Gebäude_Spezielle_Eigenschaften_Enum'Succ (Gebäude_Spezielle_Eigenschaften_Enum'First) .. Gebäude_Spezielle_Eigenschaften_Enum'Last;
   -- Für Gebäude
   


   -- Für Stadt
   type StädtebereichBasis is range 0 .. 100;
   subtype StädtebereichVorhanden is StädtebereichBasis range 1 .. StädtebereichBasis'Last;
   
   

   type Stadt_Meldung_Art_Enum is (
                                   Produktion_Fertig_Enum, Hungersnot_Enum, Einheit_In_Stadtnähe_Enum
                                  );
   
   
   
   type Stadt_Meldung_Enum is (
                               Leer_Stadt_Meldung_Enum,
                               
                               Produktion_Abgeschlossen_Enum, Einheit_Unplatzierbar_Enum, Einwohner_Wachstum_Enum, Einwohner_Reduktion_Enum, Fremde_Einheit_Nahe_Stadt_Enum
                              );
   
   subtype Stadt_Meldungen_Verwendet_Enum is Stadt_Meldung_Enum range Stadt_Meldung_Enum'Succ (Stadt_Meldung_Enum'First) .. Stadt_Meldung_Enum'Last;
   
   
   
   type EinwohnerBasis is range 0 .. 100;
   subtype EinwohnerVorhanden is EinwohnerBasis range 1 .. EinwohnerBasis'Last;
   -- Für Stadt
   
   
   
   -- Fürs Baumenü
   type Bauprojektart_Enum is (
                               Leer_Bauprojektart,
                               
                               Gebäudeart_Enum, Einheitenart_Enum
                              );
   subtype Bauprojektart_Vorhanden_Enum is Bauprojektart_Enum range Bauprojektart_Enum'Succ (Bauprojektart_Enum'First) .. Bauprojektart_Enum'Last;
   -- Fürs Baumenü

end StadtDatentypen;

pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package StadtDatentypen is

   -- Für Gebäude
   type GebäudeIDMitNullwert is range 0 .. 27;
   subtype GebäudeID is GebäudeIDMitNullwert range 1 .. GebäudeIDMitNullwert'Last;

   type Gebäude_Spezielle_Eigenschaften_Enum is (
                                                  Leer_Gebäude_Spezielle_Egienschaft_Enum,
                                                  
                                                  Eigenschaft_Enum
                                                 );
   
   subtype Gebäude_Spezielle_Eigenschaften_Verwendet_Enum is Gebäude_Spezielle_Eigenschaften_Enum range Eigenschaft_Enum .. Gebäude_Spezielle_Eigenschaften_Enum'Last;
   -- Für Gebäude
   


   -- Für Stadt
   type MaximaleStädteMitNullWert is range 0 .. 100;
   subtype MaximaleStädte is MaximaleStädteMitNullWert range 1 .. 100;

   type Stadt_Meldung_Art_Enum is (
                                   Produktion_Fertig_Enum, Hungersnot_Enum, Einheit_In_Der_Nähe_Enum
                                  );
   
   type Stadt_Meldung_Enum is (
                               Leer_Stadt_Meldung_Enum,
                               
                               Produktion_Abgeschlossen_Enum, Einheit_Unplatzierbar_Enum, Einwohner_Wachstum_Enum, Einwohner_Reduktion_Enum, Fremde_Einheit_Nahe_Stadt_Enum
                              );
   
   subtype Stadt_Meldungen_Verwendet_Enum is Stadt_Meldung_Enum range Produktion_Abgeschlossen_Enum .. Stadt_Meldung_Enum'Last;
   -- Für Stadt

end StadtDatentypen;

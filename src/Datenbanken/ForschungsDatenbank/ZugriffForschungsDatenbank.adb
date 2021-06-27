pragma SPARK_Mode (On);

with ForschungsDatenbank;

with LesenGlobaleVariablen;

package body ZugriffForschungsDatenbank is

   -- Ohne ID
   function PreisOhneID
     (RasseExtern : in GlobaleDatentypen.Rassen)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return ForschungsDatenbank.ForschungListe (RasseExtern,
                                                 LesenGlobaleVariablen.WichtigesForschungsprojekt (RasseExtern => RasseExtern)
                                                ).PreisForschung;
        
   end PreisOhneID;
   -- Ohne ID
   
   -- Mit ID
   function PreisMitID
     (RasseExtern : in GlobaleDatentypen.Rassen;
      IDExtern : in GlobaleDatentypen.ForschungID)
      return GlobaleDatentypen.KostenLager
   is begin
      
      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern).PreisForschung;
        
   end PreisMitID;
   
   function AnforderungMitID
     (RasseExtern : in GlobaleDatentypen.Rassen;
      IDExtern : in GlobaleDatentypen.ForschungID;
      ArrayPositionExtern : in Positive)
      return ForschungIDMitNullWert
   is begin
      
      return ForschungsDatenbank.ForschungListe (RasseExtern, IDExtern).AnforderungForschung (ArrayPositionExtern);
        
   end AnforderungMitID;
   -- Mit ID

end ZugriffForschungsDatenbank;

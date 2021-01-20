with GlobaleDatentypen;

package KIRecords is

   type EinheitStatusRecord is record
          
      EinheitNummer : Integer;
      BewegungspunkteBeschäftigung : Integer; -- 0 = Keine Bewegungspunkte/Beschäftigung, 1 = Bewegungspunkte ohne Beschäftigung, 2 = Beschäftigung ohne Bewegungspunkte, 3 = Beschäftigung/Bewegungspunkte
      EinheitTyp : Integer;
      
   end record;

end KIRecords;

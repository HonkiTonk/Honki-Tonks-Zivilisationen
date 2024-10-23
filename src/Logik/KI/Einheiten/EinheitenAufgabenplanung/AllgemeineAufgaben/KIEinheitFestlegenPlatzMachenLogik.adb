with KartenDatentypen;
with KartenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;

with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenPlatzMachenLogik is

   function PlatzMachen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EbeneSchleife:
      for EbeneSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungDrei'Range loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungDrei'Range loop
               
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                         ÄnderungExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               if
                 Kartenwert.Waagerechte = KartenKonstanten.LeerWaagerechte
               then
                  null;
                  
               elsif
                 True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                  NeueKoordinatenExtern      => Kartenwert)
                 and
                   False = KIAufgabenVerteiltLogik.EinheitZiel (SpeziesExtern         => EinheitSpeziesNummerExtern.Spezies,
                                                                ZielKoordinatenExtern => Kartenwert)
               then
                  SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             KoordinatenExtern          => Kartenwert);
                  return True;
                 
               else
                  null;
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
      return False;
      
   end PlatzMachen;

end KIEinheitFestlegenPlatzMachenLogik;

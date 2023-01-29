with KartenDatentypen;
with KartenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;

with KIAufgabenVerteiltLogik;

package body KIEinheitFestlegenPlatzMachenLogik is
   
   -- War vorher für die Berechnung der Aufgabenwerte zuständig, kann vermutlich nach einer Anpassung der Festlegung weg. äöü
   -- function PlatzMachen
   --   (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   -- return KIDatentypen.AufgabenWichtigkeitKlein
   -- is begin
      
   --    EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
   --    BlockiertSchleife:
   --    for BlockiertSchleifenwert in EinheitenDatentypen.MaximaleEinheiten'Range loop
         
   --      case
   --        Vergleiche.Koordinatenvergleich (KoordinateEinsExtern  => EinheitenKoordinaten,
   -- KoordinatenZweiExtern => LeseEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, BlockiertSchleifenwert)))
   --      is
   --        when True =>
   --          return KIKonstanten.PlatzFreiMachen;
               
   --       when False =>
   --         null;
   --      end case;
         
   --   end loop BlockiertSchleife;
      
   --   return KIKonstanten.UnmöglichAufgabenbewertung;
      
   -- end PlatzMachen;
   
   

   function PlatzMachen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      Einheitenkoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
               
               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Einheitenkoordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               if
                 Kartenwert.XAchse = KartenKonstanten.LeerXAchse
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
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      return False;
      
   end PlatzMachen;

end KIEinheitFestlegenPlatzMachenLogik;

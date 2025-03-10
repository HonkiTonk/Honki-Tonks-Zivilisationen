with WichtigesRecordKonstanten;
with EinheitenKonstanten;
with StadtKonstanten;
with GrafikDatentypen;

with SchreibeStadtGebaut;
with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseStadtGebaut;
with SchreibeWichtiges;
with LeseGrenzen;
with SchreibeDiplomatie;
with SchreibeSpeziesbelegung;
with SchreibeZeiger;
with SchreibeGrafiktask;
with LeseGrafiktask;

with LadezeitenLogik;

package body SpeziesEntfernenLogik is

   procedure SpeziesEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               exit EinheitenSchleife;
               
            when others =>
               SchreibeEinheitenGebaut.Nullsetzung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert));
         end case;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit StadtSchleife;
               
            when others =>
               SchreibeStadtGebaut.Nullsetzung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
            
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           DiplomatieSchleifenwert = SpeziesExtern
         then
            null;
               
         else
            SchreibeDiplomatie.GanzerEintrag (SpeziesEinsExtern => SpeziesExtern,
                                              SpeziesZweiExtern => DiplomatieSchleifenwert,
                                              EintragExtern     => WichtigesRecordKonstanten.LeerDiplomatie);
            SchreibeDiplomatie.GanzerEintrag (SpeziesEinsExtern => DiplomatieSchleifenwert,
                                              SpeziesZweiExtern => SpeziesExtern,
                                              EintragExtern     => WichtigesRecordKonstanten.LeerDiplomatie);
         end if;
         
      end loop DiplomatieSchleife;
      
      if
        SpeziesExtern = LeseGrafiktask.AktiveSpezies
      then
         SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Pause_Enum);
         
      else
         null;
      end if;
      
      SchreibeZeiger.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                    EintragExtern => WichtigesRecordKonstanten.LeerZeiger);
      SchreibeWichtiges.LeerEintrag (SpeziesExtern => SpeziesExtern);
      
      SchreibeSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesExtern);
      
   end SpeziesEntfernen;
   
   
   
   function SpeziesExistiertNoch
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return Boolean
   is begin
            
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               exit EinheitenSchleife;
               
            when others =>
               return True;
         end case;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit StadtSchleife;
               
            when others =>
               return True;
         end case;
         
      end loop StadtSchleife;
      
      SpeziesEntfernen (SpeziesExtern => SpeziesExtern);
      
      return False;
      
   end SpeziesExistiertNoch;
   
   
   
   procedure SpeziesAufKISetzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesExtern,
                                        BelegungExtern => SpeziesDatentypen.KI_Spieler_Enum);
      
      LadezeitenLogik.SpielweltNullsetzen;
      
   end SpeziesAufKISetzen;

end SpeziesEntfernenLogik;

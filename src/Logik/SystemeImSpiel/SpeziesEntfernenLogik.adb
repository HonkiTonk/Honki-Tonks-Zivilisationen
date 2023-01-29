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
with SchreibeCursor;

with LadezeitenLogik;
with NachGrafiktask;

package body SpeziesEntfernenLogik is

   procedure SpeziesEntfernen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         SchreibeEinheitenGebaut.Nullsetzung (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert));
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               SchreibeStadtGebaut.Nullsetzung (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
            
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
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
        SpeziesExtern = NachGrafiktask.AktuelleSpezies
      then
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
         
      else
         null;
      end if;
      
      SchreibeCursor.GanzerEintrag (SpeziesExtern => SpeziesExtern,
                                    EintragExtern => WichtigesRecordKonstanten.LeerCursor);
      SchreibeWichtiges.LeerEintrag (SpeziesExtern => SpeziesExtern);
      
      SchreibeSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesExtern);
      
   end SpeziesEntfernen;
   
   
   
   procedure SpeziesExistenzPrüfen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
            
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (SpeziesExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop StadtSchleife;
      
      SpeziesEntfernen (SpeziesExtern => SpeziesExtern);
      
   end SpeziesExistenzPrüfen;
   
   
   
   procedure SpeziesAufKISetzen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      SchreibeSpeziesbelegung.Belegung (SpeziesExtern  => SpeziesExtern,
                                        BelegungExtern => SpeziesDatentypen.KI_Spieler_Enum);
      LadezeitenLogik.SpielweltNullsetzen;
      
   end SpeziesAufKISetzen;

end SpeziesEntfernenLogik;

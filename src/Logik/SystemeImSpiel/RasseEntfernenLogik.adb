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
with SchreibeRassenbelegung;
with SchreibeCursor;

with LadezeitenLogik;
with NachGrafiktask;

package body RasseEntfernenLogik is

   procedure RasseEntfernen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
         
         SchreibeEinheitenGebaut.Nullsetzung (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert));
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
            
      DiplomatieSchleife:
      for DiplomatieSchleifenwert in RassenDatentypen.Rassen_Verwendet_Enum'Range loop
         
         if
           DiplomatieSchleifenwert = RasseExtern
         then
            null;
               
         else
            SchreibeDiplomatie.GanzerEintrag (RasseEinsExtern => RasseExtern,
                                              RasseZweiExtern => DiplomatieSchleifenwert,
                                              EintragExtern   => WichtigesRecordKonstanten.LeerDiplomatie);
            SchreibeDiplomatie.GanzerEintrag (RasseEinsExtern => DiplomatieSchleifenwert,
                                              RasseZweiExtern => RasseExtern,
                                              EintragExtern   => WichtigesRecordKonstanten.LeerDiplomatie);
         end if;
         
      end loop DiplomatieSchleife;
      
      if
        RasseExtern = NachGrafiktask.AktuelleRasse
      then
         NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Pause_Enum;
         
      else
         null;
      end if;
      
      SchreibeCursor.GanzerEintrag (RasseExtern   => RasseExtern,
                                    EintragExtern => WichtigesRecordKonstanten.LeerCursor);
      SchreibeWichtiges.LeerEintrag (RasseExtern => RasseExtern);
      
      SchreibeRassenbelegung.Besiegt (RasseExtern => RasseExtern);
      
   end RasseEntfernen;
   
   
   
   procedure RasseExistenzPrüfen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
            
      EinheitenSchleife:
      for EinheitSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (RasseExtern => RasseExtern) loop
         
         case
           LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (RasseExtern, EinheitSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop EinheitenSchleife;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               return;
         end case;
         
      end loop StadtSchleife;
      
      RasseEntfernen (RasseExtern => RasseExtern);
      
   end RasseExistenzPrüfen;
   
   
   
   procedure RasseAufKISetzen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SchreibeRassenbelegung.Belegung (RasseExtern    => RasseExtern,
                                       BelegungExtern => RassenDatentypen.KI_Spieler_Enum);
      LadezeitenLogik.SpielweltNullsetzen;
      
   end RasseAufKISetzen;

end RasseEntfernenLogik;

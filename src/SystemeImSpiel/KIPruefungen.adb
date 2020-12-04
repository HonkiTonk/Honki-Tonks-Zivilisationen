package body KIPruefungen is

   function SpezielleEinheitArtSuchen (Rasse, WelcheEinheitArt : in Integer) return Integer is
   begin
      
      EinheitSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID = 0 then
            exit EinheitSchleife;

         elsif EinheitenDatenbank.EinheitenListe (Rasse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitNummer).ID).SiedlerLandeinheitSeeeinheitLufteinheit = WelcheEinheitArt then
            return EinheitNummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;

      return SchleifenPruefungen.RückgabeWert;
      
   end SpezielleEinheitArtSuchen;

end KIPruefungen;

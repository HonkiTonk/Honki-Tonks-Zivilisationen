package body KIPruefungen is

   function SpezielleEinheitArtSuchen (RasseExtern, WelcheEinheitArt : in Integer) return Integer is
   begin
      
      EinheitSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop
         
         if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 0 then
            exit EinheitSchleife;

         elsif EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).SiedlerLandeinheitSeeeinheitLufteinheit = WelcheEinheitArt then
            return EinheitNummer;
            
         else
            null;
         end if;
         
      end loop EinheitSchleife;

      return SchleifenPruefungen.RückgabeWert;
      
   end SpezielleEinheitArtSuchen;



   -- 0 = Keine Bewegungspunkte/Beschäftigung, 1 = Bewegungspunkte ohne Beschäftigung, 2 = Beschäftigung ohne Bewegungspunkte, 3 = Beschäftigung/Bewegungspunkte
   function EinheitMitBewegungspunktenSuchen (RasseExtern : in Integer) return GlobaleDatentypen.EinheitStatusRecord is
   begin

      EinheitSchleife:
      for EinheitNummer in GlobaleVariablen.EinheitenGebaut'Range (2) loop

         if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID = 0 then
            return (SchleifenPruefungen.RückgabeWert, SchleifenPruefungen.RückgabeWert, SchleifenPruefungen.RückgabeWert);

         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte /= 0.00 then
            case GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung is
               when 0 =>
                  return (EinheitNummer, 1, EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).SiedlerLandeinheitSeeeinheitLufteinheit);
                  
               when others =>
                  return (EinheitNummer, 3, EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).SiedlerLandeinheitSeeeinheitLufteinheit);
            end case;
            
         elsif GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBewegungspunkte = 0.00 then
            case GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AktuelleBeschäftigung is
               when 0 =>
                  return (EinheitNummer, 0, EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).SiedlerLandeinheitSeeeinheitLufteinheit);
                  
               when others =>
                  return (EinheitNummer, 2, EinheitenDatenbank.EinheitenListe (RasseExtern, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).ID).SiedlerLandeinheitSeeeinheitLufteinheit);
            end case;
                  
         else
            null;
         end if;
         
      end loop EinheitSchleife;
      
      return (SchleifenPruefungen.RückgabeWert, SchleifenPruefungen.RückgabeWert, SchleifenPruefungen.RückgabeWert);
      
   end EinheitMitBewegungspunktenSuchen;



   -- function

end KIPruefungen;

package body KI is

   procedure KI (RasseExtern : in GlobaleDatentypen.Rassen) is
   begin
      
      if GlobaleVariablen.EinheitenGebaut (RasseExtern, 1).ID = 0 and GlobaleVariablen.StadtGebaut (RasseExtern, 1).ID = 0 then
         GlobaleVariablen.RassenImSpiel (RasseExtern) := 0;
                  
      else
         KIAktivität (RasseExtern => RasseExtern);
      end if; 
      
   end KI;



   procedure KIAktivität (RasseExtern : in GlobaleDatentypen.Rassen) is -- Von hier aus dann die einzelnen Tätigkeiten aufrufen
   begin
      
      GesamteAktivitätSchleife:
      loop
         
         EinheitStatus := KIPruefungen.EinheitMitBewegungspunktenSuchen (RasseExtern => RasseExtern);
         
         case EinheitStatus.BewegungspunkteBeschäftigung is
            when SchleifenPruefungen.RückgabeWert =>               
               exit GesamteAktivitätSchleife;
               
            when 0 | 2 => -- 0 = Keine Bewegungspunkte/Beschäftigung, 1 = Bewegungspunkte ohne Beschäftigung, 2 = Beschäftigung ohne Bewegungspunkte, 3 = Beschäftigung/Bewegungspunkte
               exit GesamteAktivitätSchleife;
               
            when others => -- 1 | 3
               null;
         end case;

         AktivitätSchleife:
         loop            

            case EinheitStatus.EinheitTyp is
               when 1 =>
                  KIStadtBauen (RasseExtern   => RasseExtern,
                                EinheitStatus => EinheitStatus);
                
               when others =>
                  KIBefestigen (RasseExtern   => RasseExtern,
                                EinheitStatus => EinheitStatus);
            end case;

            case EinheitExistiertNoch is
               when False =>
                  exit AktivitätSchleife;
                  
               when True =>
                  null;
            end case;
            
            if GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AktuelleBewegungspunkte = 0.00
              or GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AktuelleBeschäftigung /= 0 then
               exit AktivitätSchleife;
            
            else
               null;
            end if;
            
         end loop AktivitätSchleife;
         
      end loop GesamteAktivitätSchleife;
      
   end KIAktivität;
   
      
   
   procedure KIStadtBauen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      if Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.YAchse,
                        GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.XAchse).Felderwertung >= 85 then         
         StadtErfolgreichGebaut := InDerStadt.StadtBauen (RasseExtern   => RasseExtern,
                                                          EinheitNummer => EinheitStatus.EinheitNummer);

         case StadtErfolgreichGebaut is
            when True =>
               EinheitenDatenbank.EinheitEntfernen (RasseExtern   => RasseExtern,
                                                    EinheitNummer => EinheitStatus.EinheitNummer);
               
            when False =>
               KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                                      EinheitStatus => EinheitStatus);
         end case;
         
      else
         KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                                EinheitStatus => EinheitStatus);
      end if;
      
   end KIStadtBauen;
   
   
   
   procedure KIVerbesserungAnlegen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      null;
      
   end KIVerbesserungAnlegen;
   


   procedure KIGebäudeBauen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      null;
      
   end KIGebäudeBauen;
      
      
      
   procedure KIBefestigen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
         
      KIBewegung.KIBewegung (RasseExtern   => RasseExtern,
                             EinheitStatus => EinheitStatus);
         
   end KIBefestigen;
      
      
      
   procedure KIAngreifen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
         
      null;
         
   end KIAngreifen;

end KI;

package body KIBewegung is

   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin

      case EinheitStatus.EinheitTyp is
         when 1 .. 100 =>
            BewegungSiedler (RasseExtern   => RasseExtern,
                             EinheitStatus => EinheitStatus);
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AktuelleBewegungspunkte := 0.00;
      end case;
      
   end KIBewegung;



   procedure BewegungSiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin

      Bewegungsziel := (0, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.YAchse, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.XAchse);
      
      Schleife:
      for Durchgang in 1 .. 2 loop
         YAchseSchleife:
         for YAchse in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XAchse in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
               Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.YAchse,
                                                                 XKoordinate    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.XAchse,
                                                                 YÄnderung      => YAchse,
                                                                 XÄnderung      => XAchse,
                                                                 ZusatzYAbstand => 0);
            
               case Kartenwert.YAchse is
                  when GlobaleDatentypen.Kartenfeld'First =>
                     exit XAchseSchleife;
                  
                  when others =>
                     case Durchgang is
                        when 1 =>
                           if Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 2 or Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund = 31 then
                              null;
                              
                           elsif Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Felderwertung
                             > Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.YAchse,
                                              GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.XAchse).Felderwertung then
                              Bewegungsziel := (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse);
                              exit Schleife;

                           else
                              null;
                           end if;
                           
                        when others =>
                           case Karten.Karten (0, Kartenwert.YAchse, Kartenwert.XAchse).Grund is
                              when 2 | 31 =>
                                 null;
                                 
                              when others =>
                                 Bewegungsziel := (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse);
                                 exit Schleife;
                           end case;
                     end case;
               end case;           
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop Schleife;

      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.YAchse := Bewegungsziel.YAchse;
      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AchsenPosition.XAchse := Bewegungsziel.XAchse;

      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitStatus.EinheitNummer).AktuelleBewegungspunkte := 0.00;
      
   end BewegungSiedler;



   procedure BewegungBauarbeiter (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitStatus : KIRecords.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungUnterwasserEinheit;

end KIBewegung;

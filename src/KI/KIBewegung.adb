package body KIBewegung is

   procedure KIBewegung (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin

      case EinheitStatus.EinheitTyp is
         when 1 .. 100 =>
            BewegungSiedler (Rasse         => Rasse,
                             EinheitStatus => EinheitStatus);
            
         when others =>
            GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).AktuelleBewegungspunkte := 0.00;
      end case;
      
   end KIBewegung;



   procedure BewegungSiedler (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin

      Bewegungsziel := (GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).XAchse);
      
      Schleife:
      for Durchgang in 1 .. 2 loop
         YAchseSchleife:
         for YAchse in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XAchse in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
               Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).YAchse,
                                                                 XKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).XAchse,
                                                                 YÄnderung      => YAchse,
                                                                 XÄnderung      => XAchse,
                                                                 ZusatzYAbstand => 0);
            
               case Kartenwert.YWert is
                  when GlobaleDatentypen.Kartenfeld'First =>
                     exit XAchseSchleife;
                  
                  when others =>
                     case Durchgang is
                        when 1 =>
                           if Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund = 2 or Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund = 31 then
                              null;
                              
                           elsif Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Felderwertung
                             > Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).YAchse, GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).XAchse).Felderwertung then
                              Bewegungsziel := (Kartenwert.YWert, Kartenwert.XWert);
                              exit Schleife;

                           else
                              null;
                           end if;
                           
                        when others =>
                           case Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund is
                              when 2 | 31 =>
                                 null;
                                 
                              when others =>
                                 Bewegungsziel := (Kartenwert.YWert, Kartenwert.XWert);
                                 exit Schleife;
                           end case;
                     end case;
               end case;           
            
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop Schleife;

      GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).YAchse := Bewegungsziel.YWert;
      GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).XAchse := Bewegungsziel.XWert;

      GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).AktuelleBewegungspunkte := 0.00;
      
   end BewegungSiedler;



   procedure BewegungBauarbeiter (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      null;
      
   end BewegungUnterwasserEinheit;

end KIBewegung;

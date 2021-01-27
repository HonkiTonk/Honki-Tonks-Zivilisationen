package body KIBewegung is

   procedure KIBewegung (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive; Aufgabe : Wide_Wide_Character) is
   begin

      -- 1 = Siedler, 2 = Bauarbeiter, 3 = NahkampfLand, 4 = FernkampfLand, 5 = NahkampfSee, 6 = FernkampfSee, 7 = NahkampfLuft, 8 = FernkampfLuft
      -- f = Flucht, s = Stadt bauen, e = Erkunden, a = Angreifen
      case Aufgabe is
         when 'f' =>
            null;

         when 's' =>
            null;

         when 'e' =>
            null;
            
         when 'a' =>
            null;
            
         when others =>
            null;
      end case;
      
      BewegungSiedler (RasseExtern   => RasseExtern,
                       EinheitNummer => EinheitNummer);
      
   end KIBewegung;



   procedure BewegungSiedler (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin

      Schleife:
      for Durchgang in 1 .. 2 loop
         YAchseSchleife:
         for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
               if YÄnderung = 0 and XÄnderung = 0 then
                  null;

               else
                  Bewegung := BewegungssystemEinheiten.ZwischenEbene (RasseExtern   => RasseExtern,
                                                                      EinheitNummer => EinheitNummer,
                                                                      YÄnderung     => YÄnderung,
                                                                      XÄnderung     => XÄnderung);

                  case Bewegung is
                     when 1 => -- Bewegung auf Feld möglich.
                        Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                                          XKoordinate    => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse,
                                                                          YÄnderung     => YÄnderung,
                                                                          XÄnderung     => XÄnderung,
                                                                          ZusatzYAbstand => 0);
                        
                        ErfolgreichBewegt := Bewegen (Durchgang     => Durchgang,
                                                      RasseExtern   => RasseExtern,
                                                      EinheitNummer => EinheitNummer,
                                                      EAchse        => GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.EAchse,
                                                      YAchse        => Kartenwert.YAchse,
                                                      XAchse        => Kartenwert.XAchse);

                        case ErfolgreichBewegt is
                           when True =>
                              exit Schleife;
                              
                           when False =>
                              null;
                        end case;
                     
                     when 0 => -- Außerhalb der Karte oder Feld blockiert durch eigene Einheit.
                        null;
                     
                     when -1 => -- Gegnerische Einheit oder Stadt auf dem Feld.
                        null;
                  end case;
               end if;  
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop Schleife;
   
   end BewegungSiedler;



   function Bewegen (Durchgang : in Positive; RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      case Durchgang is
         when 1 =>
            if Karten.Karten (EAchse, YAchse, XAchse).Felderwertung > Karten.Karten (0, GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.YAchse,
                                                                                                      GlobaleVariablen.EinheitenGebaut (RasseExtern, EinheitNummer).AchsenPosition.XAchse).Felderwertung then
               AltePosition := IstDasEineAltePosition (RasseExtern   => RasseExtern,
                                                       EinheitNummer => EinheitNummer,
                                                       EAchse        => EAchse,
                                                       YAchse        => YAchse,
                                                       XAchse        => XAchse);
                        
               case AltePosition is
                  when True =>
                     return False;
                              
                  when False =>
                     BewegungDurchführen (RasseExtern   => RasseExtern,
                                           EinheitNummer => EinheitNummer,
                                           EAchse        => EAchse,
                                           YAchse        => YAchse,
                                           XAchse        => XAchse);                                          
                     return True;
               end case;
                           
            else
               return False;
            end if;
                           
         when others =>                      
            AltePosition := IstDasEineAltePosition (RasseExtern   => RasseExtern,
                                                    EinheitNummer => EinheitNummer,
                                                    EAchse        => EAchse,
                                                    YAchse        => YAchse,
                                                    XAchse        => XAchse);
                                    
            case AltePosition is
               when True =>
                  return False;
                                          
               when False =>
                  BewegungDurchführen (RasseExtern   => RasseExtern,
                                        EinheitNummer => EinheitNummer,
                                        EAchse        => EAchse,
                                        YAchse        => YAchse,
                                        XAchse        => XAchse);                                          
                  return True;
            end case;
      end case; 
      
   end Bewegen;



   function IstDasEineAltePosition (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) return Boolean is
   begin
      
      for AltePositionen in KIVariablen.LetzteBewegungen'Range (3) loop
         
         if KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, AltePositionen) = (EAchse, YAchse, XAchse) then
            return True;
            
         else
            null;
         end if;
         
      end loop;
      
      return False;
      
   end IstDasEineAltePosition;



   procedure BewegungDurchführen (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : in Positive; EAchse : in GlobaleDatentypen.Ebene; YAchse, XAchse : in GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 3) := KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 2);
      KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 2) := KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 1);
      KIVariablen.LetzteBewegungen (RasseExtern, EinheitNummer, 1) := (EAchse, YAchse, XAchse);
      
      BewegungssystemEinheiten.BewegungEinheitenBerechnung (RasseExtern   => RasseExtern,
                                                            EinheitNummer => EinheitNummer,
                                                            YPosition     => YAchse,
                                                            XPosition     => XAchse);
            
   end BewegungDurchführen;



   procedure BewegungBauarbeiter (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungBauarbeiter;
   
   
   
   procedure BewegungBodenEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungBodenEinheit;
   
   
   
   procedure BewegungLuftEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungLuftEinheit;
   
   
   
   procedure BewegungWasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungWasserEinheit;
   
   
   
   procedure BewegungUnterwasserEinheit (RasseExtern : in GlobaleDatentypen.Rassen; EinheitNummer : Positive) is
   begin
      
      null;
      
   end BewegungUnterwasserEinheit;

end KIBewegung;

package body KI is

   procedure KI is
   begin
      
      RasseSchleife:
      for Rasse in GlobaleVariablen.RassenImSpiel'Range loop
         
         case GlobaleVariablen.RassenImSpiel (Rasse) is
            when 0 | 1 => -- Nicht belegt | Menschlicher Spieler
               null;
               
            when others => -- KI
               KIAktivität (Rasse => Rasse);       
         end case;         

      end loop RasseSchleife;
      
   end KI;



   procedure KIAktivität (Rasse : in Integer) is -- Von hier aus dann die einzelnen Tätigkeiten aufrufen
   begin
      
      GesamteAktivitätSchleife:
      loop
         
         EinheitStatus := KIPruefungen.EinheitMitBewegungspunktenSuchen (Rasse => Rasse);
         
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
                  KIStadtBauen (Rasse         => Rasse,
                                EinheitStatus => EinheitStatus);
                
               when others =>
                  KIBefestigen (Rasse         => Rasse,
                                EinheitStatus => EinheitStatus);
            end case;

            case EinheitExistiertNoch is
               when False =>
                  exit AktivitätSchleife;
                  
               when True =>
                  null;
            end case;
            
            if GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).AktuelleBewegungspunkte = 0.00 or GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).AktuelleBeschäftigung /= 0 then
               exit AktivitätSchleife;
            
            else
               null;
            end if;
            
         end loop AktivitätSchleife;
         
      end loop GesamteAktivitätSchleife;
      
   end KIAktivität;
   
      
   
   procedure KIStadtBauen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin

      Ressourcen := (others => 0);
            
      YÄnderungSchleife:
      for YÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XÄnderungSchleife:
         for XÄnderung in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).YAchse,
                                                              XKoordinate    => GlobaleVariablen.EinheitenGebaut (Rasse, EinheitStatus.EinheitNummer).XAchse,
                                                              YÄnderung      => YÄnderung,
                                                              XÄnderung      => XÄnderung,
                                                              ZusatzYAbstand => 0);
            
            case Kartenwert.YWert is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit XÄnderungSchleife;
                  
               when others =>
                  Ressourcen (1) := Ressourcen (1) + KartenDatenbank.KartenObjektListe (Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund).Nahrungsgewinnung;
                  Ressourcen (2) := Ressourcen (2) + KartenDatenbank.KartenObjektListe (Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund).Ressourcengewinnung;
                  Ressourcen (3) := Ressourcen (3) + KartenDatenbank.KartenObjektListe (Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund).Geldgewinnung;
                  Ressourcen (4) := Ressourcen (4) + KartenDatenbank.KartenObjektListe (Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund).Wissensgewinnung;
                  Ressourcen (5) := Ressourcen (5) + KartenDatenbank.KartenObjektListe (Karten.Karten (0, Kartenwert.YWert, Kartenwert.XWert).Grund).Verteidigungsbonus;
            end case;
            
         end loop XÄnderungSchleife;
      end loop YÄnderungSchleife;

      if Ressourcen (1) >= 2 and Ressourcen (2) >= 2 and Ressourcen (1) + Ressourcen (2) + Ressourcen (3) + Ressourcen (4) + Ressourcen (5) > 20 then
         StadtErfolgreichGebaut := InDerStadt.StadtBauen (Rasse         => Rasse,
                                                          EinheitNummer => EinheitStatus.EinheitNummer);

         case StadtErfolgreichGebaut is
            when True =>
               EinheitenDatenbank.EinheitEntfernen (Rasse         => Rasse,
                                                    EinheitNummer => EinheitStatus.EinheitNummer);
               
            when False =>
               KIBewegung.KIBewegung (Rasse         => Rasse,
                                      EinheitStatus => EinheitStatus);
         end case;
         
      else
         KIBewegung.KIBewegung (Rasse         => Rasse,
                                EinheitStatus => EinheitStatus);
      end if;
      
   end KIStadtBauen;
   
   
   
   procedure KIVerbesserungAnlegen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      null;
      
   end KIVerbesserungAnlegen;
   


   procedure KIGebäudeBauen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
      
      null;
      
   end KIGebäudeBauen;
      
      
      
   procedure KIBefestigen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
         
      KIBewegung.KIBewegung (Rasse         => Rasse,
                             EinheitStatus => EinheitStatus);
         
   end KIBefestigen;
      
      
      
   procedure KIAngreifen (Rasse : in Integer; EinheitStatus : GlobaleDatentypen.EinheitStatusRecord) is
   begin
         
      null;
         
   end KIAngreifen;

end KI;

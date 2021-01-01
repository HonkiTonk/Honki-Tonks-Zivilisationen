package body WerteFestlegen is

   procedure KartenfelderBewerten (Generierung : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      case Generierung is
         when False =>
            YAchseÄnderungSchleife:
            for YAchseÄnderung in YAchse - 3 .. YAchse + 3 loop
               XAchseÄnderungSchleife:
               for XAchseÄnderung in XAchse - 3 .. XAchse + 3 loop

                  Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YAchseÄnderung,
                                                                    XKoordinate    => XAchseÄnderung,
                                                                    YÄnderung      => 0,
                                                                    XÄnderung      => 0,
                                                                    ZusatzYAbstand => 0);

                  case Kartenwert.YAchse is
                     when GlobaleDatentypen.Kartenfeld'First =>
                        exit XAchseÄnderungSchleife;
                       
                     when others =>
                        Karten.Karten (EAchse, YAchse, XAchse).Felderwertung := 0;
                        KartenfelderBewertenKleineSchleife (EAchse => EAchse,
                                                            YAchse => YAchseÄnderung,
                                                            XAchse => XAchseÄnderung);
                  end case;
            
               end loop XAchseÄnderungSchleife;
            end loop YAchseÄnderungSchleife;
            
         when True =>
            KartenfelderBewertenKleineSchleife (EAchse => EAchse,
                                                YAchse => YAchse,
                                                XAchse => XAchse);
      end case;
      
   end KartenfelderBewerten;
      


   procedure KartenfelderBewertenKleineSchleife (EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv) is
   begin
              
      BewertungYÄnderungSchleife:
      for BewertungYÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         BewertungXÄnderungSchleife:
         for BewertungXÄnderung in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
                     
            Kartenwert := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YAchse,
                                                              XKoordinate    => XAchse,
                                                              YÄnderung      => BewertungYÄnderung,
                                                              XÄnderung      => BewertungXÄnderung,
                                                              ZusatzYAbstand => 0);
                        
            case Kartenwert.YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit BewertungXÄnderungSchleife;
                  
               when others =>
                  if BewertungYÄnderung = 3 or BewertungXÄnderung = 3 then
                     Karten.Karten (EAchse, YAchse, XAchse).Felderwertung := Karten.Karten (EAchse, YAchse, XAchse).Felderwertung
                       + ((KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Verteidigungsbonus

                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Nahrungsgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Ressourcengewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Geldgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Wissensgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Verteidigungsbonus                           

                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Verteidigungsbonus                  

                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Verteidigungsbonus) / 3);
                                 
                  elsif BewertungYÄnderung = 2 or BewertungXÄnderung = 2 then
                     Karten.Karten (EAchse, YAchse, XAchse).Felderwertung := Karten.Karten (EAchse, YAchse, XAchse).Felderwertung
                       + ((KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Verteidigungsbonus

                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Nahrungsgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Ressourcengewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Geldgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Wissensgewinnung
                          + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Verteidigungsbonus                           

                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Verteidigungsbonus                  

                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus
                          + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Verteidigungsbonus) / 2);
                     
                  else
                     Karten.Karten (EAchse, YAchse, XAchse).Felderwertung := Karten.Karten (EAchse, YAchse, XAchse).Felderwertung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Nahrungsgewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Ressourcengewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Geldgewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Wissensgewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Grund).Verteidigungsbonus

                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Nahrungsgewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Ressourcengewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Geldgewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Wissensgewinnung
                       + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).Fluss).Verteidigungsbonus                           

                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Nahrungsbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Ressourcenbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Geldbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Wissensbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungStraße).Verteidigungsbonus                  

                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Nahrungsbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Ressourcenbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Geldbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Wissensbonus
                       + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, Kartenwert.YAchse, KartenWert.XAchse).VerbesserungGebiet).Verteidigungsbonus;                              
                  end if;
            end case;
                        
                     
         end loop BewertungXÄnderungSchleife;
      end loop BewertungYÄnderungSchleife;
         
   end KartenfelderBewertenKleineSchleife;

end WerteFestlegen;

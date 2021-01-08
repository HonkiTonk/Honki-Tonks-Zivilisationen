package body WerteFestlegen is

   procedure KartenfelderBewerten (Generierung : Boolean; EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse : GlobaleDatentypen.KartenfeldPositiv) is
   begin
      
      case Generierung is
         when False =>
            YAchseÄnderungSchleife:
            for YAchseÄnderung in YAchse - 3 .. YAchse + 3 loop
               XAchseÄnderungSchleife:
               for XAchseÄnderung in XAchse - 3 .. XAchse + 3 loop

                  Kartenwert (Integer (EAchse)) := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YAchseÄnderung,
                                                                                       XKoordinate    => XAchseÄnderung,
                                                                                       YÄnderung      => 0,
                                                                                       XÄnderung      => 0,
                                                                                       ZusatzYAbstand => 0);

                  case Kartenwert (Integer (EAchse)).YAchse is
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
                     
            Kartenwert (Integer (EAchse)) := SchleifenPruefungen.KartenUmgebung (YKoordinate    => YAchse,
                                                                                 XKoordinate    => XAchse,
                                                                                 YÄnderung      => BewertungYÄnderung,
                                                                                 XÄnderung      => BewertungXÄnderung,
                                                                                 ZusatzYAbstand => 0);
            case Kartenwert (Integer (EAchse)).YAchse is
               when GlobaleDatentypen.Kartenfeld'First =>
                  exit BewertungXÄnderungSchleife;
                  
               when others =>
                  if abs (BewertungYÄnderung) = 2 or abs (BewertungXÄnderung) = 2 then
                     BewertungSelbst (EAchse              => EAchse,
                                      YAchse              => YAchse,
                                      XAchse              => XAchse,
                                      YAchseFeldAufschlag => Kartenwert (Integer (EAchse)).YAchse,
                                      XAchseFeldAufschlag => Kartenwert (Integer (EAchse)).XAchse,
                                      Teiler              => 2);

                  elsif abs (BewertungYÄnderung) = 3 or abs (BewertungXÄnderung) = 3 then
                     BewertungSelbst (EAchse              => EAchse,
                                      YAchse              => YAchse,
                                      XAchse              => XAchse,
                                      YAchseFeldAufschlag => Kartenwert (Integer (EAchse)).YAchse,
                                      XAchseFeldAufschlag => Kartenwert (Integer (EAchse)).XAchse,
                                      Teiler              => 3);

                  else
                     BewertungSelbst (EAchse              => EAchse,
                                      YAchse              => YAchse,
                                      XAchse              => XAchse,
                                      YAchseFeldAufschlag => Kartenwert (Integer (EAchse)).YAchse,
                                      XAchseFeldAufschlag => Kartenwert (Integer (EAchse)).XAchse,
                                      Teiler              => 1);
                  end if;
            end case;
                                 
         end loop BewertungXÄnderungSchleife;
      end loop BewertungYÄnderungSchleife;
         
   end KartenfelderBewertenKleineSchleife;
   
   
   
   procedure BewertungSelbst (EAchse : GlobaleDatentypen.Ebene; YAchse, XAchse, YAchseFeldAufschlag, XAchseFeldAufschlag : GlobaleDatentypen.KartenfeldPositiv; Teiler : GlobaleDatentypen.LoopRangeMinusDreiZuDrei) is
   begin
      
      Karten.Karten (EAchse, YAchse, XAchse).Felderwertung := Karten.Karten (EAchse, YAchse, XAchse).Felderwertung
        + ((KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Nahrungsgewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Ressourcengewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Geldgewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Wissensgewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Grund).Verteidigungsbonus

           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Nahrungsgewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Ressourcengewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Geldgewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Wissensgewinnung
           + KartenDatenbank.KartenObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).Fluss).Verteidigungsbonus

           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Nahrungsbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Ressourcenbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Geldbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Wissensbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungStraße).Verteidigungsbonus

           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Nahrungsbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Ressourcenbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Geldbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Wissensbonus
           + VerbesserungenDatenbank.VerbesserungObjektListe (Karten.Karten (EAchse, YAchseFeldAufschlag, XAchseFeldAufschlag).VerbesserungGebiet).Verteidigungsbonus) / GesamtproduktionStadt (Teiler));
      
   end BewertungSelbst;

end WerteFestlegen;

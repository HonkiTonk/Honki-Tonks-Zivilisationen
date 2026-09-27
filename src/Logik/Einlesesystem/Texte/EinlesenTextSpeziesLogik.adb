with EinlesenAllgemeinesHTSEB;
with MeldungssystemHTSEB;
with TextKonstantenHTSEB;

with StadtDatentypen;
with ForschungenDatentypen;
with EinheitenDatentypen;

with EinlesenTextSonstigesLogik;

package body EinlesenTextSpeziesLogik is
   
   procedure Spezies
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      EinzulesendeZeile := 1;
      AktuelleZeile := 1;
      ZeilenumwandlungsabzugForschungen := 0;
      ZeilenumwandlungsabzugEinheiten := 0;
      ZeilenumwandlungsabzugGebäude := 0;
      
      SpeziesSchleife:
      loop
         
         case
           EinlesenAllgemeinesHTSEB.VorzeitigesDateienende (AktuelleDateiExtern => DateiExtern,
                                                            AktuelleZeileExtern => EinzulesendeZeile,
                                                            DateinameExtern     => "EinlesenTextSpeziesLogik.Spezies")
         is
            when True =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextSpeziesLogik.Spezies: Einzulesende Zeile:" & EinzulesendeZeile'Wide_Wide_Image & ", aktuelle Zeile:" & AktuelleZeile'Wide_Wide_Image);
               return;
               
            when False =>
               Zwischenspeicher := EinlesenTextSonstigesLogik.TextErsetzen (TextExtern => EinlesenAllgemeinesHTSEB.TextEinlesenUngebunden (DateiExtern         => DateiExtern,
                                                                                                                                           AktuelleZeileExtern => EinzulesendeZeile,
                                                                                                                                           DateinameExtern     => "EinlesenTextSpeziesLogik.Spezies"));
               EinzulesendeZeile := EinzulesendeZeile + 1;
         end case;
         
         case
           To_Wide_Wide_String (Source => Zwischenspeicher) (1)
         is
            when TextKonstantenHTSEB.TrennzeichenTextdateien =>
               null;
               
            when others =>
               if
                 AktuelleZeile <= NameBeschreibung
               then
                  Speziestexte.NameBeschreibung (SpeziesExtern, AktuelleZeile) := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                                                                          EingelesenerTextExtern => Zwischenspeicher,
                                                                                                                          VorhandenerTextExtern  => Speziestexte.NameBeschreibung (SpeziesExtern, AktuelleZeile));
                  
               elsif
                 AktuelleZeile in NameBeschreibung + 1 .. Städtenamen
               then
                  Speziestexte.Städtenamen (SpeziesExtern, StadtDatentypen.StädtebereichVorhanden (AktuelleZeile - NameBeschreibung))
                    := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                               EingelesenerTextExtern => Zwischenspeicher,
                                                               VorhandenerTextExtern  => Speziestexte.Städtenamen (SpeziesExtern, StadtDatentypen.StädtebereichVorhanden (AktuelleZeile - NameBeschreibung)));
                  
               elsif
                 AktuelleZeile in Städtenamen + 1 .. Forschungen
               then
                  case
                    AktuelleZeile mod 2
                  is
                     when 0 =>
                        ZeilenumwandlungsabzugForschungen := ZeilenumwandlungsabzugForschungen + 1;
                        ZeilenumwandlungForschungen := AktuelleZeile - Städtenamen - ZeilenumwandlungsabzugForschungen;
                        
                        Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 2)
                          := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 2));
                        
                     when others =>
                        ZeilenumwandlungForschungen := AktuelleZeile - Städtenamen - ZeilenumwandlungsabzugForschungen;
                        
                        Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 1)
                          := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => Speziestexte.Forschungen (SpeziesExtern, ForschungenDatentypen.ForschungIDVorhanden (ZeilenumwandlungForschungen), 1));
                  end case;
                  
               elsif
                 AktuelleZeile in Forschungen + 1 .. Einheiten
               then
                  case
                    AktuelleZeile mod 2
                  is
                     when 0 =>
                        ZeilenumwandlungsabzugEinheiten := ZeilenumwandlungsabzugEinheiten + 1;
                        ZeilenumwandlungEinheiten := AktuelleZeile - Forschungen - ZeilenumwandlungsabzugEinheiten;
                        
                        Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenIDBasis (ZeilenumwandlungEinheiten), 2)
                          := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenIDBasis (ZeilenumwandlungEinheiten), 2));
                        
                     when others =>
                        ZeilenumwandlungEinheiten := AktuelleZeile - Forschungen - ZeilenumwandlungsabzugEinheiten;
                        
                        Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenIDBasis (ZeilenumwandlungEinheiten), 1)
                          := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => Speziestexte.Einheiten (SpeziesExtern, EinheitenDatentypen.EinheitenIDBasis (ZeilenumwandlungEinheiten), 1));
                  end case;
                  
               elsif
                 AktuelleZeile in Einheiten + 1 .. Gebäude
               then
                  case
                    AktuelleZeile mod 2
                  is
                     when 0 =>
                        ZeilenumwandlungsabzugGebäude := ZeilenumwandlungsabzugGebäude + 1;
                        ZeilenumwandlungGebäude := AktuelleZeile - Einheiten - ZeilenumwandlungsabzugGebäude;
                        
                        Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 2)
                          := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 2));
                        
                     when others =>
                        ZeilenumwandlungGebäude := AktuelleZeile - Einheiten - ZeilenumwandlungsabzugGebäude;
                        
                        Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 1)
                          := EinlesenTextSonstigesLogik.Einsprachig (EinsprachigExtern      => EinsprachigExtern,
                                                                     EingelesenerTextExtern => Zwischenspeicher,
                                                                     VorhandenerTextExtern  => Speziestexte.Gebäude (SpeziesExtern, StadtDatentypen.GebäudeIDVorhanden (ZeilenumwandlungGebäude), 1));
                  end case;
                                                                                                                                                
               else
                  MeldungssystemHTSEB.Logik (MeldungExtern => "EinlesenTextSpeziesLogik.Spezies: Außerhalb des Einlesebereichs");
                  return;
               end if;
                                                                                                                                                
               if
                 AktuelleZeile < Gebäude
               then
                  AktuelleZeile := AktuelleZeile + 1;
                     
               else
                  return;
               end if;
         end case;
         
      end loop SpeziesSchleife;
      
   end Spezies;

end EinlesenTextSpeziesLogik;

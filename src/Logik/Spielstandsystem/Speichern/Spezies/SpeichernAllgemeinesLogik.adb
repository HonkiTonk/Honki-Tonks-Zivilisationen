with Ada.Exceptions; use Ada.Exceptions;
with Ada.Strings.Wide_Wide_Unbounded;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpeziesDatentypen;
with SpielDatentypen;
with ZahlenDatentypen;
with SpeziesKonstanten;

with LeseAllgemeines;
with LeseSpeziesbelegung;

package body SpeichernAllgemeinesLogik is

   function Allgemeines
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use Ada.Strings.Wide_Wide_Unbounded;
      use type SystemDatentypen.EinByte;
   begin
                  
      case
        LeseAllgemeines.Gewonnen
      is
         when False =>
            GewonnenWeiterspielen := 0;
            
         when True =>
            GewonnenWeiterspielen := 1;
      end case;
      
      case
        LeseAllgemeines.Weiterspielen
      is
         when False =>
            null;
            
         when True =>
            GewonnenWeiterspielen := GewonnenWeiterspielen + 2;
      end case;
      
      SystemDatentypen.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                      GewonnenWeiterspielen);
      
      SpeziesDatentypen.Spezies_Enum'Write (Stream (File => DateiSpeichernExtern),
                                            LeseAllgemeines.SpezieszugNachLaden);
      
      SpielDatentypen.Schwierigkeitsgrad_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                     LeseAllgemeines.Schwierigkeitsgrad);
      
      ZahlenDatentypen.EigenesPositive'Write (Stream (File => DateiSpeichernExtern),
                                              LeseAllgemeines.Rundenanzahl);
      
      ZahlenDatentypen.EigenesNatural'Write (Stream (File => DateiSpeichernExtern),
                                             LeseAllgemeines.Rundengrenze);
      
      Unbounded_Wide_Wide_String'Write (Stream (File => DateiSpeichernExtern),
                                        LeseAllgemeines.Ironman);
      
      SpeziesDatentypen.Spezies_Enum'Write (Stream (File => DateiSpeichernExtern),
                                            LeseAllgemeines.PlanetVernichtet);
      
      ZahlenDatentypen.EigenerInteger'Write (Stream (File => DateiSpeichernExtern),
                                             LeseAllgemeines.Zusammenbruchszeit);
      
      ZahlenDatentypen.EigenesNatural'Write (Stream (File => DateiSpeichernExtern),
                                             LeseAllgemeines.EingesetztePZB);
            
      return Speziesbelegung (DateiSpeichernExtern => DateiSpeichernExtern);
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernAllgemeinesLogik.Allgemeines: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Allgemeines;
   
   
   
   function Speziesbelegung
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypen.EinByte;
   begin
      
      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop
         
         BesiegtAktuell := 1;
         Besiegt := 0;
         
         SpeziesSchleife:
         for SpeziesSchleifenwert in SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop
         
            SpeziesDatentypen.Spieler_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                  LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert));
         
            case
              LeseSpeziesbelegung.Besiegt (SpeziesExtern => SpeziesSchleifenwert)
            is
               when True =>
                  Besiegt := Besiegt + BesiegtAktuell;
               
               when False =>
                  null;
            end case;
         
            BesiegtAktuell := BesiegtAktuell * 2;
            
         end loop SpeziesSchleife;
      
         SystemDatentypen.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                         Besiegt);
         
      end loop BereichSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernAllgemeinesLogik.Speziesbelegung: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Speziesbelegung;

end SpeichernAllgemeinesLogik;

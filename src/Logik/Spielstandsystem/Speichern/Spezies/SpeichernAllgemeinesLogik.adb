with Ada.Exceptions;
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
   
   function Aufteilung
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      case
        Allgemeines (DateiSpeichernExtern => DateiSpeichernExtern)
      is
         when False =>
            return False;
            
         when True =>
            return Speziesbelegung (DateiSpeichernExtern => DateiSpeichernExtern);
      end case;
      
   end Aufteilung;
   
   

   function Allgemeines
     (DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use Ada.Strings.Wide_Wide_Unbounded;
      use Ada.Exceptions;
      use type SystemDatentypenHTSEB.EinByte;
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
      
      SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
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
            
      return True;
      
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
      use Ada.Exceptions;
      use type SystemDatentypenHTSEB.EinByte;
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
      
         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
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

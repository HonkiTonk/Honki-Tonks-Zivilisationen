with Ada.Exceptions;
with Ada.Strings.Wide_Wide_Unbounded;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SpielDatentypen;
with ZahlenDatentypen;
with LadezeitenDatentypen;

with LeseAllgemeines;
with LeseSpeziesbelegung;

with SpielstandAllgemeinesLogik;
with LadezeitenLogik;

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
      
      LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Allgemeines_Enum,
                                 ErhöhungExtern              => 33);
            
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
      use type SpeziesDatentypen.Spieler_Enum;
   begin
         
      BelegungSchleife:
      for BelegungSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         SpeziesDatentypen.Spieler_Enum'Write (Stream (File => DateiSpeichernExtern),
                                               LeseSpeziesbelegung.Belegung (SpeziesExtern => BelegungSchleifenwert));
            
      end loop BelegungSchleife;
      
      BesiegtAktuell := 1;
      Besiegt := 0;
      AktuelleSpezies := 0;
      SpeziesVorhanden := SpielstandAllgemeinesLogik.GesamteSpeziesanzahl (SpeichernLadenExtern => True);
      
      LadezeitenLogik.Speichern (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Allgemeines_Enum,
                                 ErhöhungExtern              => 33);
      
      BesiegtSchleife:
      for BesiegtSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => BesiegtSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               if
                 LeseSpeziesbelegung.Besiegt (SpeziesExtern => BesiegtSchleifenwert) = False
               then
                  null;
            
               else
                  Besiegt := Besiegt + BesiegtAktuell;
               end if;
               
               AktuelleSpezies := AktuelleSpezies + 1;
         
               if
                 AktuelleSpezies = SpeziesVorhanden
               then
                  SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                                       Besiegt);
            
                  exit BesiegtSchleife;
            
               elsif
                 AktuelleSpezies mod 8 = 0
               then
                  SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                                       Besiegt);
                  
                  BesiegtAktuell := 1;
                  Besiegt := 0;
                  
               else
                  BesiegtAktuell := BesiegtAktuell * 2;
               end if;
         end case;
         
      end loop BesiegtSchleife;
      
      LadezeitenLogik.SpeichernMaximum (WelcheBerechnungszeitExtern => LadezeitenDatentypen.Allgemeines_Enum);
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernAllgemeinesLogik.Speziesbelegung: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Speziesbelegung;

end SpeichernAllgemeinesLogik;

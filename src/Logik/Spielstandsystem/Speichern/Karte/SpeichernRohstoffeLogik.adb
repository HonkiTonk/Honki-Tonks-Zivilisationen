with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenrohstoffeDatentypen;

with LeseWeltkarte;

package body SpeichernRohstoffeLogik is
   
   -- Wenn ich mit Technologie das Erzeugen von Rohstoffen erlauben will, dann muss ich das auch immer mitspeichern. äöü
   -- Auch im Himmel und im Orbit. äöü
   -- Eventuell eine Abfrage einbauen ob schon eine Spezies in der Lage ist dies zu tun und nur dann mitspeichern? äöü
   function Rohstoffe
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is begin
      
      case
        KoordinatenExtern.Ebene
      is
         when KartenDatentypen.EbeneLuft'Range =>
            return True;
            
         when others =>
            null;
      end case;
      
      RohstoffeSchleife:
      for RohstoffeSchleifenwert in KartenrohstoffeDatentypen.Rohstoffanzahl_Enum'Range loop
         
         KartenrohstoffeDatentypen.Rohstoffe_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                         LeseWeltkarte.Rohstoffe (KoordinatenExtern    => KoordinatenExtern,
                                                                                  RohstoffnummerExtern => RohstoffeSchleifenwert));
         
      end loop RohstoffeSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernRohstoffeLogik.Rohstoffe: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Rohstoffe;

end SpeichernRohstoffeLogik;

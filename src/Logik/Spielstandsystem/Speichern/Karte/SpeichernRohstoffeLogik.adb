with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with LeseWeltkarte;

package body SpeichernRohstoffeLogik is
   
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
         
         Rohstoff := LeseWeltkarte.Rohstoffe (KoordinatenExtern => KoordinatenExtern,
                                              RohstoffExtern    => RohstoffeSchleifenwert);
         case
           Rohstoff
         is
            when KartenrohstoffeDatentypen.Leer_Rohstoffe_Enum =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernRohstoffeLogik.Rohstoffe: Kein Rohstoff.");
               return False;
               
            when others =>
               KartenrohstoffeDatentypen.Rohstoffe_Vorhanden_Enum'Write (Stream (File => DateiSpeichernExtern),
                                                                         Rohstoff);
         end case;
         
      end loop RohstoffeSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernRohstoffeLogik.Rohstoffe: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Rohstoffe;

end SpeichernRohstoffeLogik;

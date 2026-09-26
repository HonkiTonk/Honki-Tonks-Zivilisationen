with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with SchreibeWeltkarte;

package body LadenRohstoffeLogik is

   function Rohstoffe
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      LadenPrüfenExtern : in Boolean)
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
                  
         KartenrohstoffeDatentypen.Rohstoffe_Enum'Read (Stream (File => DateiLadenExtern),
                                                        Rohstoff);
         case
           LadenPrüfenExtern
         is
            when True =>
               SchreibeWeltkarte.Rohstoffe (KoordinatenExtern    => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                            RohstoffnummerExtern => RohstoffeSchleifenwert,
                                            RohstoffExtern       => Rohstoff);
               
            when False =>
               null;
         end case;
         
      end loop RohstoffeSchleife;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenRohstoffeLogik.Rohstoffe: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end Rohstoffe;

end LadenRohstoffeLogik;

with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;

with SchreibeWeltkarte;

package body LadenBasisgrundLogik is
   
   function BasisgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
            
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.WeltraumKonstante =>
            Basisgrund := KartengrundDatentypen.Weltraum_Enum;
            
         when KartenKonstanten.HimmelKonstante =>
            Basisgrund := KartengrundDatentypen.Wolken_Enum;
            
         when KartenKonstanten.OberflächeKonstante | KartenKonstanten.UnterflächeKonstante | KartenKonstanten.PlaneteninneresKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Basisgrund);
      end case;
      
      case
        LadenPrüfenExtern
      is
         when True =>
            SchreibeWeltkarte.Basisgrund (KoordinatenExtern => (KoordinatenExtern.Ebene, KoordinatenExtern.Senkrechte, KoordinatenExtern.Waagerechte),
                                          GrundExtern       => Basisgrund);
            
         when False =>
            null;
      end case;
      
      return True;
      
   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadenBasisgrundLogik.BasisgrundEinlesen: Konnte nicht geladen werden: LadenPrüfenExtern = " & LadenPrüfenExtern'Wide_Wide_Image & " "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;
      
   end BasisgrundEinlesen;

end LadenBasisgrundLogik;

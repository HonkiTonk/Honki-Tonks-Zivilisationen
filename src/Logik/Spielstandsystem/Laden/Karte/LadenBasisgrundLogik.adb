with Ada.Exceptions; use Ada.Exceptions;

with MeldungssystemHTSEB;
with UmwandlungssystemHTSEB;

with KartenKonstanten;

with SchreibeWeltkarte;

package body LadenBasisgrundLogik is
   
   function BasisgrundEinlesen
     (DateiLadenExtern : in File_Type;
      KoordinatenExtern : in KartenRecords.KartenfeldVorhandenRecord;
      KartenfeldExtern : in KartenRecords.KartenfeldumgebungPositivRecord;
      LadenPrüfenExtern : in Boolean)
      return Boolean
   is begin
      
      -- Man kann das teilweise zusammenfassen, aber mal getrennt lassen für spätere, potentielle Verbesserungen.
      case
        KoordinatenExtern.Ebene
      is
         when KartenKonstanten.WeltraumKonstante =>
            Basisgrund := KartengrundDatentypen.Weltraum_Enum;
            
         when KartenKonstanten.HimmelKonstante =>
            Basisgrund := KartengrundDatentypen.Wolken_Enum;
            
         when KartenKonstanten.OberflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Basisgrund);
            
         when KartenKonstanten.UnterflächeKonstante =>
            KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                  Basisgrund);
            
         when KartenKonstanten.PlaneteninneresKonstante =>
            -- YKernanfang := LeseWeltkarteneinstellungen.Senkrechte / 2 - LeseWeltkarteneinstellungen.Senkrechte / 10;
            -- XKernanfang := LeseWeltkarteneinstellungen.Waagerechte / 2 - LeseWeltkarteneinstellungen.Waagerechte / 10;
            -- YKernende := LeseWeltkarteneinstellungen.Senkrechte / 2 + LeseWeltkarteneinstellungen.Senkrechte / 10;
            -- XKernende := LeseWeltkarteneinstellungen.Waagerechte / 2 + LeseWeltkarteneinstellungen.Waagerechte / 10;
            if
              KoordinatenExtern.Senkrechte in KartenfeldExtern.Senkrechte / 2 - KartenfeldExtern.Senkrechte / 10 .. KartenfeldExtern.Senkrechte / 2 + KartenfeldExtern.Senkrechte / 10
              and
                KoordinatenExtern.Waagerechte in KartenfeldExtern.Waagerechte / 2 - KartenfeldExtern.Waagerechte / 10 .. KartenfeldExtern.Waagerechte / 2 + KartenfeldExtern.Waagerechte / 10
            then
               Basisgrund := KartengrundDatentypen.Planetenkern_Enum;
               
            else
               KartengrundDatentypen.Basisgrund_Vorhanden_Enum'Read (Stream (File => DateiLadenExtern),
                                                                     Basisgrund);
            end if;
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

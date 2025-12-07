
Псевдоэлементы служат для обращения к отдельным частям элементов, тогда как псевдоклассы позволяют стилям различать разные типы элементов.

https://drafts.csswg.org/selectors/#overview

.title::before {
content: "“";
position: absolute;
}

.title::after {
content: attr(cite);
display: block;
font-style: italic;
}

https://gist.github.com/dmitry-osin/c64f7d8eb9ed60cc932c4c56ac7eae22

before / after
https://github.com/Max-Starling/Notes/blob/master/CSS.md#%D0%BF%D1%81%D0%B5%D0%B2%D0%B4%D0%BE%D0%BA%D0%BB%D0%B0%D1%81%D1%81%D1%8B-%D0%B8-%D0%BF%D1%81%D0%B5%D0%B2%D0%B4%D0%BE%D1%8D%D0%BB%D0%B5%D0%BC%D0%B5%D0%BD%D1%82%D1%8B
https://www.youtube.com/watch?v=RGBozr0FUCo&t=326s

https://webref.ru/css/selector
https://doka-guide.vercel.app/css/tag-selector/
https://dan-it.gitlab.io/fe-book/programming_essentials/html_css/ext_30_useful_css-selectors/ext_30_useful_css-selectors.html
https://devreflex.ru/html-css/selektory-v-css
https://www.w3.org/TR/selectors-3/#universal-selector
https://css-live.ru/articles-css/impossible-pseudos.html
